#namespace TFLV::Upgrade;
#debug off

const UPGRADES_PER_LEVEL = 4;

class ::Registry : Object play {
  array<string> upgrade_names;
  array<::BaseUpgrade> upgrades;

  static ::Registry GetRegistry() {
    let reg = TFLV::EventHandler(StaticEventHandler.Find("TFLV::EventHandler"));
    DEBUG("GetRegistry: %s", TFLV::Util.SafeCls(reg));
    if (!reg) return null;
    return reg.UPGRADE_REGISTRY;
  }

  static void Register(string upgrade) {
    DEBUG("Register: %s", upgrade);
    if (GetRegistry().upgrade_names.find(upgrade) != GetRegistry().upgrade_names.size()) {
      // Assume that this is because a mod has tried to double-register an upgrade,
      // and permit it as a no-op.
      //ThrowAbortException("Duplicate upgrades named %s", upgrade);
      return;
    }
    GetRegistry().upgrade_names.push(upgrade);
    GetRegistry().upgrades.push(::BaseUpgrade(new(upgrade)));
  }

  // Can't be static because we need to call it during eventmanager initialization,
  // and at that point the EventHandler isn't findable.
  void RegisterBuiltins() {
    DEBUG("RegisterBuiltins");
    static const string UpgradeNames[] = {
      // "::Agonizer",
      "::AmmoLeech",
      "::ArmourLeech",
      // "::Beam", TODO: fix interactions with HE shots and similar
      "::BlastShaping",
      "::BouncyShots",
      "::DarkHarvest",
      "::ExplosiveDeath",
      "::ExplosiveShots",
      "::FastShots",
      "::FragmentationShots",
      "::HomingShots",
      // "::Ignition",
      "::Juggler",
      "::LifeLeech",
      "::PiercingShots",
      "::PlayerDamage",
      "::Shield",
      "::Submunitions",
      "::Swiftness",
      "::Thorns",
      "::ToughAsNails",
      "::WeaponDamage",
      // Fire upgrades
      "::IncendiaryShots",
      "::BurningTerror",
      "::Conflagration",
      "::InfernalKiln",
      // Poison upgrades
      "::PoisonShots",
      "::Weakness",
      "::Putrefaction",
      "::Hallucinogens",
      // Acid upgrades
      "::CorrosiveShots",
      "::ConcentratedAcid",
      "::AcidSpray",
      "::Embrittlement",
      // Lightning upgrades
      "::ShockingInscription",
      "::Revivification",
      "::ChainLightning",
      "::Thunderbolt",
      // Dual-element power moves
      "::ElementalBeam",
      "::ElementalBlast",
      "::ElementalWave"
    };
    for (uint i = 0; i < UpgradeNames.size(); ++i) {
      upgrade_names.push(UpgradeNames[i]);
      upgrades.push(::BaseUpgrade(new(UpgradeNames[i])));
    }
    // Only load Indestructable if the mod itself is installed.
    string forcename = "TFIS_IndestructableForce";
    class<Actor> cls = forcename;
    if (cls) {
      upgrade_names.push("::Indestructable");
      upgrades.push(::BaseUpgrade(new("::Indestructable")));
    }
  }

  static void PickN(Array<::BaseUpgrade> dst, Array<::BaseUpgrade> src, uint n) {
    uint max = src.size();
    while (max > 0 && dst.size() < n) {
      uint i = random(0, max-1);
      dst.push(src[i]);
      src[i] = src[--max];
    }
  }

  static void GenerateUpgradesForPlayer(
      TFLV::PerPlayerStats stats, Array<::BaseUpgrade> generated) {
    Array<::BaseUpgrade> candidates;
    // Array<::BaseUpgrade> all_upgrades = GetRegistry().upgrades;
    for (uint i = 0; i < GetRegistry().upgrades.size(); ++i) {
      if (GetRegistry().upgrades[i].IsSuitableForPlayer(stats))
        candidates.push(GetRegistry().upgrades[i]);
    }

    PickN(generated, candidates, UPGRADES_PER_LEVEL);
  }

  static void GenerateUpgradesForWeapon(
      TFLV::WeaponInfo info, Array<::BaseUpgrade> generated) {
    array<::BaseUpgrade> candidates;
    for (uint i = 0; i < GetRegistry().upgrades.size(); ++i) {
      if (GetRegistry().upgrades[i].IsSuitableForWeapon(info))
        candidates.push(GetRegistry().upgrades[i]);
    }

    PickN(generated, candidates, UPGRADES_PER_LEVEL);
  }
}