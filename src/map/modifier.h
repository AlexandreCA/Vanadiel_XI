﻿/*
===========================================================================
  Copyright (c) 2010-2015 Darkstar Dev Teams
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/
===========================================================================
*/

#ifndef _CMODIFIER_H
#define _CMODIFIER_H

#include "common/cbasetypes.h"

enum class Mod
{
    // IF YOU ADD ANY NEW MODIFIER HERE, ADD IT IN scripts/enum/mod.lua ASWELL!
    NONE = 0,            // Essential, but does nothing :)
                         //  NAME                  = ID, // Comment
    DEF          = 1,    // Target's Defense
    HP           = 2,    // Target's HP
    HPP          = 3,    // HP Percentage
    CONVMPTOHP   = 4,    // MP -> HP (Cassie Earring)
    MP           = 5,    // MP +/-
    MPP          = 6,    // MP Percentage
    CONVHPTOMP   = 7,    // HP -> MP
    WEAKNESS_PCT = 1093, // Weakness HP/MP reduction term, -1 = - 1% HP/MP
    CURSE_PCT    = 1094, // Curse HP/MP reduction term, -1 = - 1% HP/MP
    BASE_HP      = 1095, // Base HP bonus (like merits)
    BASE_MP      = 1096, // Base MP bonus (like merits)
    FOOD_HP      = 1130, // Food HP (this is added after curse)
    FOOD_MP      = 1131, // Food MP (this is added after curse)

    STR = 8,  // Strength
    DEX = 9,  // Dexterity
    VIT = 10, // Vitality
    AGI = 11, // Agility
    INT = 12, // Intelligence
    MND = 13, // Mind
    CHR = 14, // Charisma

    TWOHAND_STR = 218, // Same as STR, but only active when using a two handed weapon (e.g. Hasso)

    // Magic Evasion versus elements
    // This has been repeatedly mixed up with SDT - be careful!
    FIRE_MEVA    = 15, // Fire Magic Evasion
    ICE_MEVA     = 16, // Ice Magic Evasion
    WIND_MEVA    = 17, // Wind Magic Evasion
    EARTH_MEVA   = 18, // Earth Magic Evasion
    THUNDER_MEVA = 19, // Thunder Magic Evasion
    WATER_MEVA   = 20, // Water Magic Evasion
    LIGHT_MEVA   = 21, // Light Magic Evasion
    DARK_MEVA    = 22, // Dark Magic Evasion

    // Magic Evasion RANK versus elements (resistance ranks)
    FIRE_RES_RANK    = 192, // Fire Resistance Rank
    ICE_RES_RANK     = 193, // Ice Resistance Rank
    WIND_RES_RANK    = 194, // Wind Resistance Rank
    EARTH_RES_RANK   = 195, // Earth Resistance Rank
    THUNDER_RES_RANK = 196, // Thunder Resistance Rank
    WATER_RES_RANK   = 197, // Water Resistance Rank
    LIGHT_RES_RANK   = 198, // Light Resistance Rank
    DARK_RES_RANK    = 199, // Dark Resistance Rank

    ATT  = 23, // Attack
    RATT = 24, // Ranged Attack

    ACC  = 25, // Accuracy
    RACC = 26, // Ranged Accuracy

    TWOHAND_ACC = 219, // Same as ACC, but only active when using a two handed weapon (e.g. Hasso)

    ENMITY                = 27,  // Enmity
    ENMITY_LOSS_REDUCTION = 427, // Reduces Enmity lost when taking damage

    MATT = 28, // Magic Attack
    MDEF = 29, // Magic Defense
    MACC = 30, // Magic Accuracy - note that this is NOT iLvl "magic accuracy skill" which happens in item_weapon.sql
    MEVA = 31, // Magic Evasion

    // Magic Accuracy and Elemental Attacks
    FIRE_MAB     = 32, // Elemental "Magic Attack Bonus" aka "Affinity"
    ICE_MAB      = 33, // Elemental "Magic Attack Bonus" aka "Affinity"
    WIND_MAB     = 34, // Elemental "Magic Attack Bonus" aka "Affinity"
    EARTH_MAB    = 35, // Elemental "Magic Attack Bonus" aka "Affinity"
    THUNDER_MAB  = 36, // Elemental "Magic Attack Bonus" aka "Affinity"
    WATER_MAB    = 37, // Elemental "Magic Attack Bonus" aka "Affinity"
    LIGHT_MAB    = 38, // Elemental "Magic Attack Bonus" aka "Affinity"
    DARK_MAB     = 39, // Elemental "Magic Attack Bonus" aka "Affinity"
    FIRE_MACC    = 40, // Fire Accuracy
    ICE_MACC     = 41, // Ice Accuracy
    WIND_MACC    = 42, // Wind Accuracy
    EARTH_MACC   = 43, // Earth Accuracy
    THUNDER_MACC = 44, // Thunder Accuracy
    WATER_MACC   = 45, // Water Accuracy
    LIGHT_MACC   = 46, // Light Accuracy
    DARK_MACC    = 47, // Dark Accuracy

    // Day/Weather elemental bonuses.
    FORCE_FIRE_DWBONUS      = 531,  // Set to above 0 to force fire day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_ICE_DWBONUS       = 532,  // Set to above 0 to force ice day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_WIND_DWBONUS      = 533,  // Set to above 0 to force wind day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_EARTH_DWBONUS     = 534,  // Set to above 0 to force earth day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_LIGHTNING_DWBONUS = 535,  // Set to above 0 to force lightning day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_WATER_DWBONUS     = 536,  // Set to above 0 to force water day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_LIGHT_DWBONUS     = 537,  // Set to above 0 to force light day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_DARK_DWBONUS      = 538,  // Set to above 0 to force dark day/weather elemental bonuses. Penalties are NOT forced.
    FORCE_DW_BONUS_PENALTY  = 1156, // Set to above 0 to force all day/weather elemental bonus AND penalties. This is used by "Hachirin-no-Obi".

    WSACC = 48, // Weaponskill Accuracy

    ATTP = 62, // % Attack
    DEFP = 63, // % Defense

    COMBAT_SKILLUP_RATE = 64, // % increase in skillup combat rate
    MAGIC_SKILLUP_RATE  = 65, // % increase in skillup magic rate

    RATTP = 66, // % Ranged Attack

    EVA            = 68,  // Evasion
    RDEF           = 69,  // Ranged Defense
    REVA           = 70,  // Ranged Evasion
    MPHEAL         = 71,  // MP Recovered while healing
    HPHEAL         = 72,  // HP Recovered while healing
    STORETP        = 73,  // Increases the rate at which TP is gained
    TACTICAL_PARRY = 486, // Tactical Parry Tp Bonus
    INHIBIT_TP     = 488, // Inhibits TP Gain (percent)

    // Working Skills (weapon combat skills)
    // These are NOT item Level skill, they are skill in your status menu. iLvl "skill" happens in item_weapon.sql
    HTH               = 80,  // Hand To Hand Skill
    DAGGER            = 81,  // Dagger Skill
    SWORD             = 82,  // Sword Skill
    GSWORD            = 83,  // Great Sword Skill
    AXE               = 84,  // Axe Skill
    GAXE              = 85,  // Great Axe Skill
    SCYTHE            = 86,  // Scythe Skill
    POLEARM           = 87,  // Polearm Skill
    KATANA            = 88,  // Katana Skill
    GKATANA           = 89,  // Great Katana Skill
    CLUB              = 90,  // Club Skill
    STAFF             = 91,  // Staff Skill
    AUTO_MELEE_SKILL  = 101, // Automaton Melee Skill -- Do not apply to items in item_mods_pet.sql, apply only to master (it does not work properly on pet mods)
    AUTO_RANGED_SKILL = 102, // Automaton Range Skill -- Do not apply to items in item_mods_pet.sql, apply only to master (it does not work properly on pet mods)
    AUTO_MAGIC_SKILL  = 103, // Automaton Magic Skill -- Do not apply to items in item_mods_pet.sql, apply only to master (it does not work properly on pet mods)
    ARCHERY           = 104, // Archery Skill
    MARKSMAN          = 105, // Marksman Skill
    THROW             = 106, // Throw Skill
    GUARD             = 107, // Guard Skill
    EVASION           = 108, // Evasion Skill
    SHIELD            = 109, // Shield Skill
    PARRY             = 110, // Parry Skill

    // Magic Skills
    DIVINE    = 111, // Divine Magic Skill
    HEALING   = 112, // Healing Magic Skill
    ENHANCE   = 113, // Enhancing Magic Skill
    ENFEEBLE  = 114, // Enfeebling Magic Skill
    ELEM      = 115, // Elemental Magic Skill
    DARK      = 116, // Dark Magic Skill
    SUMMONING = 117, // Summoning Magic Skill
    NINJUTSU  = 118, // Ninjutsu Magic Skill
    SINGING   = 119, // Singing Magic Skill
    STRING    = 120, // String Magic Skill
    WIND      = 121, // Wind Magic Skill
    BLUE      = 122, // Blue Magic Skill
    GEOMANCY  = 123, // Geomancy Magic Skill
    HANDBELL  = 124, // Handbell Magic SKill

    // Synthesis Skills
    FISH      = 127, // Fishing Skill
    WOOD      = 128, // Woodworking Skill
    SMITH     = 129, // Smithing Skill
    GOLDSMITH = 130, // Goldsmithing Skill
    CLOTH     = 131, // Clothcraft Skill
    LEATHER   = 132, // Leathercraft Skill
    BONE      = 133, // Bonecraft Skill
    ALCHEMY   = 134, // Alchemy Skill
    COOK      = 135, // Cooking Skill
    SYNERGY   = 136, // Synergy Skill
    RIDING    = 137, // Riding Skill

    // Fishing gear modifiers
    PENGUIN_RING_EFFECT   = 152, // +2 on fishing arrow delay / fish movement for mini - game
    ALBATROSS_RING_EFFECT = 153, // adds 30 seconds to mini - game time
    PELICAN_RING_EFFECT   = 154, // adds extra skillup roll for fishing
    FISHING_SKILL_GAIN    = 155, // food for fishing skill ups

    // Damage - 10000 base, 375 = 3.75%
    DMG                     = 160, // Damage Taken %
    DMGPHYS                 = 161, // Physical Damage Taken %
    DMGPHYS_II              = 190, // Physical Damage Taken II % (Burtgang)
    UDMGPHYS                = 387, // Uncapped Damage Multipliers
    DMGBREATH               = 162, // Breath Damage Taken %
    UDMGBREATH              = 388, // Used in sentinel, invincible, physical shield etc
    DMGMAGIC                = 163, // Magic Damage Taken %
    DMGMAGIC_II             = 831, // Magic Damage Taken II % (Aegis)
    UDMGMAGIC               = 389,
    DMGRANGE                = 164, // Range Damage Taken %
    UDMGRANGE               = 390,
    DMG_AOE                 = 158, // Damage Taken % when not main target of an AoE action. (Ex: Locus Mobs)
    RECEIVED_DAMAGE_CAP     = 221, // Caps the damage taken recieved by the attacker
    RECEIVED_DAMAGE_VARIANT = 222, // The variance that you want the damage cap to changed by. Ex: If you want the damage to be from 90-100 instead of a flat 100 you can set this to 10. It will random the value between 90-100 if the damage is above 100.

    // Specific Damage Taken vs physical damage type
    SLASH_SDT  = 49, // Slash Damage Taken. Base 10000. 100% = 0
    PIERCE_SDT = 50, // Piercing Damage Taken. Base 10000. 100% = 0
    IMPACT_SDT = 51, // Impact Damage Taken. Base 10000. 100% = 0
    HTH_SDT    = 52, // Hand-To-Hand Damage Taken. Base 10000. 100% = 0

    // Elemental SDT. BASE 10000. This has been repeatedly mixed up with RESISTANCE - be careful!
    FIRE_SDT    = 54, // Fire Damage Taken
    ICE_SDT     = 55, // Ice Damage Taken
    WIND_SDT    = 56, // Wind Damage Taken
    EARTH_SDT   = 57, // Earth Damage Taken
    THUNDER_SDT = 58, // Thunder Damage Taken
    WATER_SDT   = 59, // Water Damage Taken
    LIGHT_SDT   = 60, // Light Damage Taken
    DARK_SDT    = 61, // Dark Damage Taken

    // Occasionally annuls damage taken. Modifier value = chance in %
    NULL_DAMAGE          = 142, // Occasionally annuls all/any damage.
    NULL_PHYSICAL_DAMAGE = 416, // Occasionally annuls physical damage.
    NULL_BREATH_DAMAGE   = 143, // Occasionally annuls breath damage.
    NULL_MAGICAL_DAMAGE  = 476, // Occasionally annuls magical damage.
    NULL_RANGED_DAMAGE   = 239, // Occasionally annuls ranged damage.
    FIRE_NULL            = 467, // Occasionally annuls fire elemental damage.
    ICE_NULL             = 468, // Occasionally annuls ice elemental damage.
    WIND_NULL            = 469, // Occasionally annuls wind elemental damage.
    EARTH_NULL           = 470, // Occasionally annuls earth elemental damage.
    LTNG_NULL            = 471, // Occasionally annuls thunder elemental damage.
    WATER_NULL           = 472, // Occasionally annuls water elemental damage.
    LIGHT_NULL           = 473, // Occasionally annuls light elemental damage.
    DARK_NULL            = 474, // Occasionally annuls dark elemental damage.

    // Occasionally absorbs damage taken. Modifier value = chance in %
    ABSORB_DMG_CHANCE = 480, // Occasionally absorbs all/any damage.
    PHYS_ABSORB       = 512, // Occasionally absorbs physical damage. USED FOR RANGED ASWELL.
    MAGIC_ABSORB      = 475, // Occasionally absorbs magical damage.
    FIRE_ABSORB       = 459, // Occasionally absorbs fire elemental damage.
    ICE_ABSORB        = 460, // Occasionally absorbs ice elemental damage.
    WIND_ABSORB       = 461, // Occasionally absorbs wind elemental damage.
    EARTH_ABSORB      = 462, // Occasionally absorbs earth elemental damage.
    LTNG_ABSORB       = 463, // Occasionally absorbs thunder elemental damage.
    WATER_ABSORB      = 464, // Occasionally absorbs water elemental damage.
    LIGHT_ABSORB      = 465, // Occasionally absorbs light elemental damage.
    DARK_ABSORB       = 466, // Occasionally absorbs dark elemental damage.

    // Crit Damage / Delay
    CRITHITRATE              = 165, // Raises chance to crit
    CRITHITRATE_ONLY_WEP     = 141, // Raises chance to crit (but only for attacks with the specific weapon that has the mod)
    CRIT_DMG_INCREASE        = 421, // Raises the damage of critical hit by percent %
    RANGED_CRIT_DMG_INCREASE = 964, // Increases ranged critical damage by a percent
    CRITICAL_HIT_EVASION     = 166, // Modifies chance enemy will crit
    CRIT_DEF_BONUS           = 908, // Reduces crit hit damage
    MAGIC_CRITHITRATE        = 562, // Raises chance to magic crit
    MAGIC_CRIT_DMG_INCREASE  = 563, // Raises damage done when criting with magic

    FENCER_TP_BONUS    = 903, // TP Bonus to weapon skills from Fencer Trait
    FENCER_CRITHITRATE = 904, // Increased Crit chance from Fencer Trait

    SMITE          = 898, // Raises attack when using H2H or 2H weapons (256 scale)
    TACTICAL_GUARD = 899, // Tp increase when guarding
    GUARD_PERCENT  = 976, // Guard Percent

    HASTE_MAGIC           = 167, // Haste (and Slow) from magic - 10000 base, 375 = 3.75%
    HASTE_ABILITY         = 383, // Haste (and Slow) from abilities - 10000 base, 375 = 3.75%
    HASTE_GEAR            = 384, // Haste (and Slow) from equipment - 10000 base, 375 = 3.75%
    TWOHAND_HASTE_ABILITY = 217, // Haste (and Slow) from abilities - 10000 base, 375 = 3.75% - Only applies to auto attacks when using two handed weapons, additive to HASTE_ABILITY
    SPELLINTERRUPT        = 168, // % Spell Interruption Rate

    // Movement speed modifiers in use order.
    MOUNT_MOVE                = 972,  // % Mount Movement Speed
    MOVE_SPEED_STACKABLE      = 75,   // Additive modifier. Applied before multipliers. Gear movement speed penalties.
    MOVE_SPEED_WEIGHT_PENALTY = 77,   // Multiplicative modifier. For Gravity and curse.
    MOVE_SPEED_FLEE           = 1085, // Multiplicative modifier.
    MOVE_SPEED_CHEER          = 1087, // Multiplicative modifier from "cheer" type KI's.
    MOVE_SPEED_GEAR_BONUS     = 76,   // Multiplicative modifier. Gear movement speed bonuses. DOES NOT STACK with each other, only highest applies.
    MOVE_SPEED_QUICKENING     = 78,   // Additive modifier. Applied after multipliers. Jig, spreinter shoes, etc. Shares cap with Mazurka.
    MOVE_SPEED_MAZURKA        = 79,   // Additive modifier. Applied after multipliers. Song movement speed. Shares cap with Quickening,
    MOVE_SPEED_BOLTERS_ROLL   = 1086, // Additive modifier. Applied after multipliers.
    MOVE_SPEED_OVERRIDE       = 169,  // Modifier used to overide regular speed caps. (GM speed and Feast of Swords)

    FASTCAST                = 170, // Increases Spell Cast Time (TRAIT)
    UFASTCAST               = 407, // uncapped fast cast
    CURE_CAST_TIME          = 519, // cure cast time reduction
    ELEMENTAL_CELERITY      = 901, // Quickens Elemental Magic Casting
    DELAY                   = 171, // Increase/Decrease Delay
    RANGED_DELAY            = 172, // Increase/Decrease Ranged Delay
    MARTIAL_ARTS            = 173, // The integer amount of delay to reduce from H2H weapons' base delay. (TRAIT)
    SKILLCHAINBONUS         = 174, // Damage bonus applied to skill chain damage.  Modifier from effects/traits
    SKILLCHAINDMG           = 175, // Damage bonus applied to skill chain damage.  Modifier from gear (multiplicative after effect/traits)
    MAX_SWINGS              = 978, // Max swings for "Occasionally attacks X times"
    ADDITIONAL_SWING_CHANCE = 979, // Chance that allows for an additional swing despite of multiple hits, mostly for Amood weapons

    MAGIC_DAMAGE = 311, // Magic damage added directly to the spell's base damage

    // FOOD!
    FOOD_HPP      = 176, //
    FOOD_HP_CAP   = 177, //
    FOOD_MPP      = 178, //
    FOOD_MP_CAP   = 179, //
    FOOD_ATTP     = 180, //
    FOOD_ATT_CAP  = 181, //
    FOOD_DEFP     = 182, //
    FOOD_DEF_CAP  = 183, //
    FOOD_ACCP     = 184, //
    FOOD_ACC_CAP  = 185, //
    FOOD_RATTP    = 186, //
    FOOD_RATT_CAP = 187, //
    FOOD_RACCP    = 188, //
    FOOD_RACC_CAP = 189, //
    FOOD_MACCP    = 99,  // Macc% see https://www.bg-wiki.com/bg/Category:Magic_Accuracy_Food
    FOOD_MACC_CAP = 100, // Sets Upper limit for FOOD_MACCP
    FOOD_DURATION = 937, // Percentage to increase food duration

    // Killer-Effects - (Most by Traits/JobAbility)
    VERMIN_KILLER   = 224, // Enhances "Vermin Killer" effect
    BIRD_KILLER     = 225, // Enhances "Bird Killer" effect
    AMORPH_KILLER   = 226, // Enhances "Amorph Killer" effect
    LIZARD_KILLER   = 227, // Enhances "Lizard Killer" effect
    AQUAN_KILLER    = 228, // Enhances "Aquan Killer" effect
    PLANTOID_KILLER = 229, // Enhances "Plantiod Killer" effect
    BEAST_KILLER    = 230, // Enhances "Beast Killer" effect
    UNDEAD_KILLER   = 231, // Enhances "Undead Killer" effect
    ARCANA_KILLER   = 232, // Enhances "Arcana Killer" effect
    DRAGON_KILLER   = 233, // Enhances "Dragon Killer" effect
    DEMON_KILLER    = 234, // Enhances "Demon Killer" effect
    EMPTY_KILLER    = 235, // Enhances "Empty Killer" effect
    HUMANOID_KILLER = 236, // Enhances "Humanoid Killer" effect
    LUMINIAN_KILLER = 237, // Enhances "Luminian Killer" effect
    LUMINION_KILLER = 238, // Enhances "Luminion Killer" effect

    // Resistances to enfeebles - Job Traits/Job Abilities/Atmas/Items/Gear
    SLEEPRES    = 240, // Enhances "Resist Sleep" effect
    POISONRES   = 241, // Enhances "Resist Poison" effect
    PARALYZERES = 242, // Enhances "Resist Paralyze" effect
    BLINDRES    = 243, // Enhances "Resist Blind" effect
    SILENCERES  = 244, // Enhances "Resist Silence" effect
    VIRUSRES    = 245, // Enhances "Resist Virus" effect
    PETRIFYRES  = 246, // Enhances "Resist Petrify" effect
    BINDRES     = 247, // Enhances "Resist Bind" effect
    CURSERES    = 248, // Enhances "Resist Curse" effect
    GRAVITYRES  = 249, // Enhances "Resist Gravity" effect
    SLOWRES     = 250, // Enhances "Resist Slow" effect
    STUNRES     = 251, // Enhances "Resist Stun" effect
    CHARMRES    = 252, // Enhances "Resist Charm" effect
    AMNESIARES  = 253, // Enhances "Resist Amnesia" effect
    LULLABYRES  = 254, // Enhances "Resist Lullaby" effect
    DEATHRES    = 255, // Used by gear and ATMA that give resistance to instance KO
    STATUSRES   = 958, // "Resistance to All Status Ailments"

    // MEVA bonus to enfeebles (Bar-Effect, for example. And modifiers in mobs)
    SLEEP_MEVA    = 200,
    POISON_MEVA   = 201,
    PARALYZE_MEVA = 202,
    BLIND_MEVA    = 203,
    SILENCE_MEVA  = 204,
    VIRUS_MEVA    = 205,
    PETRIFY_MEVA  = 206,
    BIND_MEVA     = 207,
    CURSE_MEVA    = 208,
    GRAVITY_MEVA  = 209,
    SLOW_MEVA     = 210,
    STUN_MEVA     = 211,
    CHARM_MEVA    = 212,
    AMNESIA_MEVA  = 213,
    LULLABY_MEVA  = 214,
    DEATH_MEVA    = 215,
    STATUS_MEVA   = 216,

    // Status effect Immunobreak modifiers.
    SLEEP_IMMUNOBREAK    = 261,
    POISON_IMMUNOBREAK   = 262,
    PARALYZE_IMMUNOBREAK = 263,
    BLIND_IMMUNOBREAK    = 264,
    SILENCE_IMMUNOBREAK  = 265,
    PETRIFY_IMMUNOBREAK  = 266,
    BIND_IMMUNOBREAK     = 267,
    GRAVITY_IMMUNOBREAK  = 268,
    SLOW_IMMUNOBREAK     = 269,
    ADDLE_IMMUNOBREAK    = 270,

    PARALYZE      = 257, // Paralyze -- percent chance to proc
    MIJIN_RERAISE = 258, // Augments Mijin Gakure
    DUAL_WIELD    = 259, // Percent reduction in dual wield delay.

    // fTP modifiers
    FIRE_FTP_BONUS    = 544,  // Gives bonus fTP when weaponskill has a Fire property. (Elemental beltes and gorgets) /256
    ICE_FTP_BONUS     = 545,  // Gives bonus fTP when weaponskill has a Ice property. (Elemental beltes and gorgets) /256
    WIND_FTP_BONUS    = 546,  // Gives bonus fTP when weaponskill has a Wind property. (Elemental beltes and gorgets) /256
    EARTH_FTP_BONUS   = 547,  // Gives bonus fTP when weaponskill has a Earth property. (Elemental beltes and gorgets) /256
    THUNDER_FTP_BONUS = 548,  // Gives bonus fTP when weaponskill has a Thunder property. (Elemental beltes and gorgets) /256
    WATER_FTP_BONUS   = 549,  // Gives bonus fTP when weaponskill has a Water property. (Elemental beltes and gorgets) /256
    LIGHT_FTP_BONUS   = 550,  // Gives bonus fTP when weaponskill has a Light property. (Elemental beltes and gorgets) /256
    DARK_FTP_BONUS    = 551,  // Gives bonus fTP when weaponskill has a Dark property. (Elemental beltes and gorgets) /256
    ANY_FTP_BONUS     = 1144, // Gives bonus fTP when weaponskill has a (any) property. (Fotia Gorget, Fotia Belt) /256
    DAY_FTP_BONUS     = 1145, // Gives bonus fTP when weaponskill has a property that matches current day. (Mekira Oto, Gavialis helm, etc...) /256

    // Warrior
    DOUBLE_ATTACK       = 288,  // Percent chance to proc
    DOUBLE_ATTACK_DMG   = 1038, // Increases "Double Attack" damage/"Double Attack" damage + (in percents, e.g. +20 = +20% damage)
    WARCRY_DURATION     = 483,  // Warcy duration bonus from gear
    BERSERK_POTENCY     = 948,  // Augments "Berserk"/Enhances "Berserk" effect (Conqueror)
    BERSERK_DURATION    = 954,  // Berserk Duration
    AGGRESSOR_DURATION  = 955,  // Aggressor Duration
    DEFENDER_DURATION   = 956,  // Defender Duration
    ENHANCES_RESTRAINT  = 1045, // Enhances "Restraint" effect/"Restraint" + (Increases the damage bonus of Restraint by XXX%)
    ENHANCES_BLOOD_RAGE = 1046, // Enhances "Blood Rage" effect/"Blood Rage" duration +

    // Monk
    BOOST_EFFECT        = 97,    // Boost power in tenths
    CHAKRA_MULT         = 1026,  // Chakra multiplier increase (from gear)
    CHAKRA_REMOVAL      = 1027,  // Extra statuses removed by Chakra
    SUBTLE_BLOW         = 289,   // How much TP to reduce.
    COUNTER             = 291,   // Percent chance to counter
    KICK_ATTACK_RATE    = 292,   // Percent chance to kick
    PERFECT_COUNTER_ATT = 428,   // TODO: Raises weapon damage by 20 when countering while under the Perfect Counter effect. This also affects Weapon Rank (though
                                 // not if fighting barehanded).
    COUNTER_DAMAGE       = 1047, // Increases Damage from Counter Attacks (Percent)
    FOOTWORK_ATT_BONUS   = 429,  // Raises the attack bonus of Footwork. (Tantra Gaiters +2 raise 25/256 to 38/256)
    COUNTERSTANCE_EFFECT = 543,  // Counterstance effect in percents
    DODGE_EFFECT         = 552,  // Dodge effect in percents
    FOCUS_EFFECT         = 561,  // Focus effect in percents
    ADDITIVE_GUARD       = 1092, // Additive % bonus to final Guard rate (adds after clamp)
    AUGMENTS_IMPETUS     = 1097, // see https://www.bg-wiki.com/ffxi/Impetus, adds Crit Hit Damage & Accuracy for Impetus

    // White Mage
    AFFLATUS_SOLACE  = 293, // Pool of HP accumulated during Afflatus Solace
    AFFLATUS_MISERY  = 294, // Pool of HP accumulated during Afflatus Misery
    AUSPICE_EFFECT   = 484, // Bonus to Auspice Subtle Blow Effect.
    AOE_NA           = 524, // % to make -na spells/erase always AoE w/ Divine Veil
    REGEN_MULTIPLIER = 838, // Multiplier to base regen rate
    CURE2MP_PERCENT  = 860, // Converts % of "Cure" amount to MP
    DIVINE_BENISON   = 910, // Adds fast cast and enmity reduction to -Na spells (includes Erase). Enmity reduction is half of the fast cast amount
    REGEN_BONUS      = 989, // Increases the amount of HP restored by Regen

    // Black Mage
    CLEAR_MIND              = 295,  // Used in conjunction with HEALMP to increase amount between tics
    CONSERVE_MP             = 296,  // Percent chance
    ELEMENTAL_MAGIC_RECAST  = 1146, // Recast time for elemental magic spells (percent, usually negative)
    ENHANCES_ELEMENTAL_SEAL = 1149, // Bonus magic damage when using Elemental Seal (percent)
    ELEMENTAL_DEBUFF_EFFECT = 1150, // Increase stat reduction by N, and DoT by N/2 HP per tick

    // Red Mage
    BLINK             = 299,  // Tracks blink shadows
    STONESKIN         = 300,  // Tracks stoneskin HP pool
    PHALANX           = 301,  // Tracks direct damage reduction
    ENF_MAG_POTENCY   = 290,  // Increases Enfeebling magic potency %
    ENF_MAG_DURATION  = 1151, // Increases enfeebling magic duration %
    ENHANCES_SABOTEUR = 297,  // Increases Saboteur Potency %

    // Thief
    FLEE_DURATION        = 93,   // Flee duration in seconds
    STEAL                = 298,  // Increase/Decrease THF Steal chance
    DESPOIL              = 896,  // Increases THF Despoil chance
    PERFECT_DODGE        = 883,  // Increases Perfect Dodge duration in seconds
    TRIPLE_ATTACK        = 302,  // Percent chance
    TRIPLE_ATTACK_DMG    = 1039, // Increases "Triple Attack" damage/"Triple Attack" damage + (in percents, e.g. +20 = +20% damage)
    TREASURE_HUNTER      = 303,  // Percent chance
    TREASURE_HUNTER_PROC = 1048, // Increases Treasure Hunter proc rate (percent)
    TREASURE_HUNTER_CAP  = 1049, // Increases the Treasure Hunter Cap (e.g. THF JP Gift)
    SNEAK_ATK_DEX        = 830,  // % DEX boost to Sneak Attack (if gear mod, needs to be equipped on hit)
    TRICK_ATK_AGI        = 520,  // % AGI boost to Trick Attack (if gear mod, needs to be equipped on hit)
    MUG_EFFECT           = 835,  // Mug effect as multiplier
    ACC_COLLAB_EFFECT    = 884,  // Increases amount of enmity transferred for Accomplice/Collaborator
    HIDE_DURATION        = 885,  // Hide duration increase (percentage based)
    GILFINDER            = 897,  // Gilfinder, duh

    // Paladin
    HOLY_CIRCLE_DURATION   = 857,  // Holy Circle extended duration in seconds
    HOLY_CIRCLE_POTENCY    = 1141, // Increases the potency of the Holy Circle effect (e.g. mod value 2 = +2% Undead Killer)
    RAMPART_DURATION       = 92,   // Rampart duration in seconds
    ABSORB_PHYSDMG_TO_MP   = 426,  // Absorbs a percentage of physical damage taken to MP.
    SHIELD_MASTERY_TP      = 485,  // Shield mastery TP bonus when blocking with a shield
    SENTINEL_EFFECT        = 837,  // Sentinel effect in percents
    SHIELD_DEF_BONUS       = 905,  // Shield Defense Bonus
    COVER_TO_MP            = 965,  // Converts a successful cover's phsyical damage to MP
    COVER_MAGIC_AND_RANGED = 966,  // Redirects ranged and single target magic attacks to the cover ability user
    COVER_DURATION         = 967,  // Increases Cover Duration
    ENHANCES_CHIVALRY      = 1061, // Enhances "Chivalry" effect (increases the base TP modifier by the provided value / 100, e.g. mod value 5 = +0.05)
    ENHANCES_DIVINE_EMBLEM = 1062, // Enhances "Divine Emblem" effect/"Divine Emblem" + (increases the ability's special enmity bonus by the provided value)
    ENHANCES_FEALTY        = 1063, // Enhances "Fealty" effect (increases Fealty's duration by 4 seconds per Fealty merit)
    ENHANCES_IRON_WILL     = 1064, // Enhances "Iron Will" effect (adds +3% Fast Cast per Iron Will merit to Rampart)
    ENHANCES_GUARDIAN      = 1065, // Enhances "Guardian" effect (increases Sentinel's duration by 2 seconds per Guardian merit)
    PALISADE_BLOCK_BONUS   = 1066, // Increases base block rate while under the effects of Palisade (additive, not multiplicative)
    REPRISAL_BLOCK_BONUS   = 1067, // Increases block rate while under the effects of Reprisal (multiplicative, not additive)
    REPRISAL_SPIKES_BONUS  = 1068, // Increases Reprisal spikes damage by percentage (e.g. mod value 50 = +50% spikes damage)
    SHIELD_BARRIER         = 1082, // Grants a bonus to Protect spells cast by self while a shield is equipped.

    // Dark Knight
    ARCANE_CIRCLE_DURATION  = 858,  // Arcane Circle extended duration in seconds
    ARCANE_CIRCLE_POTENCY   = 1069, // Increases the potency of the Arcane Circle effect (e.g. mod value 2 = +2% Arcana Killer)
    SOULEATER_EFFECT        = 96,   // Souleater power in percents
    SOULEATER_EFFECT_II     = 53,   // Uncapped additive Souleaterbonus in percents, 10 = .1
    DESPERATE_BLOWS         = 906,  // Adds ability haste to Last Resort
    STALWART_SOUL           = 907,  // Reduces damage taken from Souleater
    DREAD_SPIKES_EFFECT     = 998,  // Percent increase to total HP drain for Dread Spikes
    DARK_MAGIC_CAST         = 1071, // Reduces Dark Magic Casting Time by percentage (e.g. mod value -10 = -10% cast time)
    DARK_MAGIC_DURATION     = 1072, // Increases Dark Magic spell durations by percentage (e.g. mod value 10 = +10% duration)
    ENHANCES_BLOOD_WEAPON   = 1070, // Enhances "Blood Weapon" effect (increases Blood Weapon's duration in seconds)
    ENHANCES_DARK_SEAL      = 1073, // Enhances "Dark Seal" effect (Increases Dark Magic spell durations by 10% per Dark Seal merit while Dark Seal active)
    ENHANCES_DIABOLIC_EYE   = 275,  // Diabolic Eye duration + "modifier-value" seconds per Diabolic Eye merit.
    ENHANCES_NETHER_VOID    = 1083, // Enhances "Nether Void" effect (Increases the potency of the next Absorb or Drain Dark Magic by <value>%
    ENHANCES_MUTED_SOUL     = 1084, // Enhances "Muted Soul" effect (Adds 3% Zanshin rate per MUTED_SOUL merit level)
    ENHANCES_ABSORB_EFFECTS = 1136, // Absorb Spell duration +x seconds (Enhances "Absorb" effects)
    AUGMENTS_ABSORB         = 1137, // Non-Liberator Absorb Spell potency +x% (Augments "Absorb" effects)
    ABSORB_EFFECT_DURATION  = 1138, // Absorb Spell duration +% ("Absorb" effect duration +x%)
    AUGMENTS_ABSORB_TP      = 1153, // Increases absorb-TP potency, stacks with AUGMENTS_ABSORB

    // Beastmaster
    TAME                         = 304,  // Additional percent chance to charm
    CHARM_TIME                   = 360,  // extends the charm time only, no effect of charm chance
    REWARD_HP_BONUS              = 364,  // Percent to add to reward HP healed. (364)
    CHARM_CHANCE                 = 391,  // extra chance to charm (light+apollo staff ect)
    FERAL_HOWL_DURATION          = 503,  // +20% duration per merit when wearing augmented Monster Jackcoat +2
    JUG_LEVEL_RANGE              = 564,  // Decreases the level range of spawned jug pets. Maxes out at 2.
    CALL_BEAST_DELAY             = 273,  // Lowers Call Beast recast
    SIC_READY_RECAST             = 1052, // SIC/Ready recast reduction (seconds)
    TANDEM_STRIKE_POWER          = 271,  // Grants a bonus to your and your pet's accuracy and magic accuracy when you and your pet are attacking the same target.
    TANDEM_BLOW_POWER            = 272,  // Reduces amount of TP gained by enemies when striking them if you and your pet are attacking the same target.
    ENHANCES_MONSTER_CORRELATION = 1155, // Grants your pet acc +X and attp +X% against a weaker opposing ecosystem. Typically applied to pet, not owner (item_mods_pet.sql)

    // Bard
    MINNE_EFFECT           = 433,  //
    MINUET_EFFECT          = 434,  //
    PAEON_EFFECT           = 435,  //
    REQUIEM_EFFECT         = 436,  //
    THRENODY_EFFECT        = 437,  //
    MADRIGAL_EFFECT        = 438,  //
    MAMBO_EFFECT           = 439,  //
    LULLABY_EFFECT         = 440,  //
    ETUDE_EFFECT           = 441,  //
    BALLAD_EFFECT          = 442,  //
    MARCH_EFFECT           = 443,  //
    FINALE_EFFECT          = 444,  //
    CAROL_EFFECT           = 445,  //
    MAZURKA_EFFECT         = 446,  //
    ELEGY_EFFECT           = 447,  //
    PRELUDE_EFFECT         = 448,  //
    HYMNUS_EFFECT          = 449,  //
    VIRELAI_EFFECT         = 450,  //
    SCHERZO_EFFECT         = 451,  //
    ALL_SONGS_EFFECT       = 452,  //
    MAXIMUM_SONGS_BONUS    = 453,  //
    SONG_DURATION_BONUS    = 454,  //
    SONG_SPELLCASTING_TIME = 455,  //
    SONG_RECAST_DELAY      = 833,  // Reduces song recast time in seconds.
    AUGMENT_SONG_STAT      = 1003, // Bonus to Stat of Element of Enhancing Song.

    // Ranger
    CAMOUFLAGE_DURATION     = 98,   // Camouflage duration in percents
    RECYCLE                 = 305,  // Percent chance to recycle
    SNAPSHOT                = 365,  // Percent reduction to range attack delay
    RAPID_SHOT              = 359,  // Percent chance to proc rapid shot
    WIDESCAN                = 340,  //
    BARRAGE_ACC             = 420,  // Barrage accuracy
    BARRAGE_COUNT           = 138,  // Increases Barrage shots by 1
    DOUBLE_SHOT_RATE        = 422,  // The rate that double shot can proc. Without this, the default is 40%.
    VELOCITY_SNAPSHOT_BONUS = 423,  // Increases Snapshot whilst Velocity Shot is up.
    VELOCITY_RATT_BONUS     = 424,  // Increases Ranged Attack whilst Velocity Shot is up.
    SHADOW_BIND_EXT         = 425,  // Extends the time of shadowbind
    SCAVENGE_EFFECT         = 312,  //
    SHARPSHOT               = 314,  //
    TRUE_SHOT_EFFECT        = 1053, // TODO: True Shot Ranged Damage increase (percent)
    DEAD_AIM_EFFECT         = 1054, // TODO: Dead Aim Critical Damage increase (percent)
    BOUNTY_SHOT_TH_BONUS    = 826,  // Boosts base TH level of bounty shot

    // Samurai
    WARDING_CIRCLE_DURATION   = 95,   // Warding Circle extended duration in seconds
    WARDING_CIRCLE_POTENCY    = 1143, // Increases the potency of the Warding Circle effect (e.g. mod value 2 = +2% Demon Killer)
    MEDITATE_DURATION         = 94,   // Meditate duration in seconds
    ZANSHIN                   = 306,  // Zanshin percent chance
    THIRD_EYE_COUNTER_RATE    = 508,  // Adds counter to 3rd eye anticipates & if using Seigan counter rate is increased by 15%
    THIRD_EYE_ANTICIPATE_RATE = 839,  // Adds anticipate rate in percents
    THIRD_EYE_BONUS           = 1055, // TODO: Bonus Third Eye Evasion (count)
    SENGIKORI_SC_DMG_DEBUFF   = 1088, // % Increase to closing skillchain damage. Applied to defender.
    SENGIKORI_MB_DMG_DEBUFF   = 1089, // % Increase to magic burst damage. Applied to defender.
    SENGIKORI_BONUS           = 1090, // additive % increase to Sengikori

    // Ninja
    UTSUSEMI             = 307, // Everyone's favorite --tracks shadows.
    UTSUSEMI_BONUS       = 900, // Extra shadows from gear
    NINJA_TOOL           = 308, // Percent chance to not use a tool.
    NIN_NUKE_BONUS_INNIN = 223, // Ninjutsu damage multiplier from Innin.
    NIN_NUKE_BONUS_GEAR  = 522, // Ninjutsu damage multiplier from gear.
    DAKEN                = 911, // chance to throw a shuriken without consuming it
    NINJUTSU_DURATION    = 1000,
    ENHANCES_SANGE       = 1091, // 1 = +1 attack for Daken during Sange per Sange merit (i.e. 20 with 5 merits = +100 attack during Sange)
    ENHANCES_FUTAE       = 1148, // Adds to the +50% bonus damage to elemental ninjutsu provided by Futae (percent)

    // Dragoon
    ANCIENT_CIRCLE_DURATION    = 859,  // Ancient Circle extended duration in seconds
    ANCIENT_CIRCLE_POTENCY     = 1142, // Increases the potency of the Ancient Circle effect (e.g. mod value 2 = +2% Dragon Killer)
    JUMP_TP_BONUS              = 361,  // bonus tp player receives when using jump
    JUMP_SPIRIT_TP_BONUS       = 285,  // bonus tp player receives when using jump for spirit jump only
    JUMP_ATT_BONUS             = 362,  // ATT% bonus for all jumps
    JUMP_SOUL_SPIRIT_ATT_BONUS = 286,  // ATT% bonus for Soul & Spirit jump only
    JUMP_ACC_BONUS             = 936,  // accuracy bonus for all jumps
    JUMP_DOUBLE_ATTACK         = 888,  // DA% bonus for all jumps
    HIGH_JUMP_ENMITY_REDUCTION = 363,  // for gear that reduces more enmity from high jump
    FORCE_JUMP_CRIT            = 828,  // Force critical hit for all jumps
    WYVERN_EFFECTIVE_BREATH    = 829,  // Increases the threshold for triggering healing breath/offensive breath more inclined to pick elemental weakness
    WYVERN_SUBJOB_TRAITS       = 974,  // Adds subjob traits to wyvern on spawn
    WYVERN_BREATH_MACC         = 986,  // Increases accuracy of wyvern's breath. adds 10 magic accuracy per merit to the trait Strafe
    WYVERN_LVL_BONUS           = 1043, // Wyvern: Lv.+ (Increases wyvern's base level above 99)
    WYVERN_ATTRIBUTE_DA        = 1056, // Adds an amount of Double Attack to Dragoon each time Wyverns Attributes Increase (percent)
    DRAGOON_BREATH_RECAST      = 1057, // Restoring/Smithing Breath Recast Reduction (seconds)
    ENHANCE_DEEP_BREATHING     = 283,  // Add 5/256 to deep breathing bonus per merit level when calculating healing breath
    UNCAPPED_WYVERN_BREATH     = 284,  // Uncapped wyvern breath boost. Used on retail for augments, normal gear should use WYVERN_BREATH.
    ENHANCES_STRAFE            = 282,  // Strafe merit augment, +50 TP gained per merit level on breath use.
    ENHANCES_SPIRIT_LINK       = 281,  // Adds erase/-na to Spirit Link

    // Summoner
    AVATAR_PERPETUATION       = 371,  // stores base cost of current avatar
    WEATHER_REDUCTION         = 372,  // stores perpetuation reduction depending on weather
    DAY_REDUCTION             = 373,  // stores perpetuation reduction depending on day
    PERPETUATION_REDUCTION    = 346,  // stores the MP/tick reduction from gear
    BP_DELAY                  = 357,  // stores blood pact delay reduction
    ENHANCES_ELEMENTAL_SIPHON = 540,  // Bonus Base MP added to Elemental Siphon skill.
    BP_DELAY_II               = 541,  // Blood Pact Delay Reduction II
    BP_DAMAGE                 = 126,  // Blood Pact: Rage Damage increase percentage
    BLOOD_BOON                = 913,  // Occasionally cuts down MP cost of Blood Pact abilities. Does not affect abilities that require Astral Flow.
    AVATARS_FAVOR_ENHANCE     = 1154, // Enhances Avatars Favor Effect by 1 tier per point
    AVATAR_LVL_BONUS          = 1040, // Avatar: Lv.+ (Increases all avatar's base level above 99)
    CARBUNCLE_LVL_BONUS       = 1041, // Carbuncle: Lv.+ (Increases Carbuncle's base level above 99)
    CAIT_SITH_LVL_BONUS       = 1042, // Cait Sith: Lv.+ (Increases Cait Sith's base level above 99)
    ENHANCES_MANA_CEDE        = 74,   // Bonus % to Mana Cede effect, +1 = 1%
    SUMMONING_MAGIC_CAST      = 1078, // Summoning magic casting time reduction in seconds
    SPIRIT_CAST_REDUCTION     = 140,  // Spirit Pact casting time reduction in seconds

    // Blue Mage
    BLUE_POINTS             = 309,  // Tracks extra blue points
    BLUE_LEARN_CHANCE       = 945,  // Additional chance to learn blue magic
    BLUE_JOB_TRAIT_BONUS    = 1058, // TODO: Increases job traits gained from equipped blue magic (percent)
    BLUE_MAGIC_EFFECT       = 1059, // TODO: Bonus to Attribute Value of spell (percent)
    ENHANCES_BURST_AFFINITY = 1139, // Increases WSC bonus on spells cast with Burst Affinity (percent)
    ENHANCES_CHAIN_AFFINITY = 1140, // TODO: Increases WSC bonus on spells cast with Chain Affinity (base damage +)
    BLUE_MAGIC_RECAST       = 1147, // Recast time for blue magic spells (percent, usually negative)

    // Corsair
    EXP_BONUS         = 382,  //
    ROLL_RANGE        = 528,  // Additional range for COR roll abilities.
    JOB_BONUS_CHANCE  = 542,  // Chance to apply job bonus to COR roll without having the job in the party.
    RANDOM_DEAL_BONUS = 220,  // % chance to reset 2 abilities
    TRIPLE_SHOT_RATE  = 999,  // Percent increase to Triple Shot Rate
    QUICK_DRAW_RECAST = 1060, // Quick Draw Charge Reduction (seconds)

    DMG_REFLECT            = 316,  // Tracks totals
    ROLL_ROGUES            = 317,  // Tracks totals
    ROLL_GALLANTS          = 318,  // Tracks totals
    ROLL_CHAOS             = 319,  // Tracks totals
    ROLL_BEAST             = 320,  // Tracks totals
    ROLL_CHORAL            = 321,  // Tracks totals
    ROLL_HUNTERS           = 322,  // Tracks totals
    ROLL_SAMURAI           = 323,  // Tracks totals
    ROLL_NINJA             = 324,  // Tracks totals
    ROLL_DRACHEN           = 325,  // Tracks totals
    ROLL_EVOKERS           = 326,  // Tracks totals
    ROLL_MAGUS             = 327,  // Tracks totals
    ROLL_CORSAIRS          = 328,  // Tracks totals
    ROLL_PUPPET            = 329,  // Tracks totals
    ROLL_DANCERS           = 330,  // Tracks totals
    ROLL_SCHOLARS          = 331,  // Tracks totals
    ROLL_BOLTERS           = 869,  // Tracks totals
    ROLL_CASTERS           = 870,  // Tracks totals
    ROLL_COURSERS          = 871,  // Tracks totals
    ROLL_BLITZERS          = 872,  // Tracks totals
    ROLL_TACTICIANS        = 873,  // Tracks totals
    ROLL_ALLIES            = 874,  // Tracks totals
    ROLL_MISERS            = 875,  // Tracks totals
    ROLL_COMPANIONS        = 876,  // Tracks totals
    ROLL_AVENGERS          = 877,  // Tracks totals
    ROLL_NATURALISTS       = 878,  // Tracks totals
    ROLL_RUNEISTS          = 879,  // Tracks totals
    BUST                   = 332,  // # of busts
    QUICK_DRAW_DMG         = 411,  // Flat damage increase to base QD damage
    QUICK_DRAW_DMG_PERCENT = 834,  // Percentage increase to QD damage
    QUICK_DRAW_MACC        = 191,  // Quick draw magic accuracy
    PHANTOM_ROLL           = 881,  // Phantom Roll+ Effect from SOA Rings.
    PHANTOM_DURATION       = 882,  // Phantom Roll Duration +.
    PHANTOM_RECAST         = 1076, // Phantom Roll Recast -.

    // Puppetmaster
    AUTO_MAB_COEFFICIENT        = 157,  // Applies a MAB multiplier to automatons. This value is the bonus %.
    MANEUVER_BONUS              = 504,  // Maneuver Stat Bonus
    OVERLOAD_THRESH             = 505,  // Overload Threshold Bonus
    AUTO_DECISION_DELAY         = 842,  // Reduces the Automaton's global decision delay
    AUTO_SHIELD_BASH_DELAY      = 843,  // Reduces the Automaton's global shield bash delay
    AUTO_MAGIC_DELAY            = 844,  // Reduces the Automaton's global magic delay
    AUTO_HEALING_DELAY          = 845,  // Reduces the Automaton's global healing delay
    AUTO_HEALING_THRESHOLD      = 846,  // Increases the healing trigger threshold
    BURDEN_DECAY                = 847,  // Increases amount of burden removed per tick
    AUTO_SHIELD_BASH_SLOW       = 848,  // Adds a slow effect to Shield Bash
    AUTO_TP_EFFICIENCY          = 849,  // Causes the Automaton to wait to form a skillchain when its master is > 90% TP
    AUTO_SCAN_RESISTS           = 850,  // Causes the Automaton to scan a target's resistances
    REPAIR_EFFECT               = 853,  // Removes # of status effects from the Automaton
    REPAIR_POTENCY              = 854,  // Note: Only affects amount regenerated by a %, not the instant restore!
    PREVENT_OVERLOAD            = 855,  // Overloading erases a water maneuver (except on water overloads) instead, if there is one
    SUPPRESS_OVERLOAD           = 125,  // Kenkonken "Suppresses Overload" mod. Unclear how this works exactly. Requires testing on retail.
    AUTO_STEAM_JACKET           = 938,  // Causes the Automaton to mitigate damage from successive attacks of the same type
    AUTO_STEAM_JACKET_REDUCTION = 939,  // Amount of damage reduced with Steam Jacket
    AUTO_SCHURZEN               = 940,  // Prevents fatal damage leaving the automaton at 1HP and consumes an Earth manuever
    AUTO_EQUALIZER              = 941,  // Reduces damage received according to damage taken
    AUTO_PERFORMANCE_BOOST      = 942,  // Increases the performance of other attachments by a percentage
    AUTO_ANALYZER               = 943,  // Causes the Automaton to mitigate damage from a special attack a number of times
    AUTO_ELEM_CAPACITY          = 987,  // Increases the automaton's elemental capacity for attachments
    AUTO_RANGED_DELAY           = 1001, // Decreases the amount of time between ranged attacks
    AUTO_RANGED_DAMAGEP         = 1002, // Increase automaton ranged weapon damage by a %
    AUTOMATON_LVL_BONUS         = 1044, // Automaton: Lv. (Increases automaton's base level above 99)

    // Dancer
    FINISHING_MOVES          = 333,  // Tracks # of finishing moves
    SAMBA_DURATION           = 490,  // Samba duration bonus
    WALTZ_POTENCY            = 491,  // Waltz Potency Bonus
    JIG_DURATION             = 492,  // Jig duration bonus in percents
    VFLOURISH_MACC           = 493,  // Violent Flourish accuracy bonus
    STEP_FINISH              = 494,  // Bonus finishing moves from steps
    STEP_ACCURACY            = 403,  // Bonus accuracy for Dancer's steps
    WALTZ_DELAY              = 497,  // Waltz Ability Delay modifier (-1 mod is -1 second)
    SAMBA_PDURATION          = 498,  // Samba percent duration bonus
    REVERSE_FLOURISH_EFFECT  = 836,  // Reverse Flourish effect in tenths of squared term multiplier
    MAX_FINISHING_MOVE_BONUS = 988,  // Increases the maximum number of finishing moves that may be stored
    WALTZ_COST               = 139,  // Reduce Waltz cost by 5tp (50 post 1000tp scale)
    STEP_TP_CONSUMED         = 1077, // Modifies the amount of TP consumed when using steps

    // Scholar
    BLACK_MAGIC_COST         = 393, // MP cost for black magic (light/dark arts)
    WHITE_MAGIC_COST         = 394, // MP cost for white magic (light/dark arts)
    BLACK_MAGIC_CAST         = 395, // Cast time for black magic (light/dark arts)
    WHITE_MAGIC_CAST         = 396, // Cast time for black magic (light/dark arts)
    BLACK_MAGIC_RECAST       = 397, // Recast time for black magic (light/dark arts)
    WHITE_MAGIC_RECAST       = 398, // Recast time for white magic (light/dark arts)
    ALACRITY_CELERITY_EFFECT = 399, // Bonus for celerity/alacrity effect
    LIGHT_ARTS_EFFECT        = 334, //
    DARK_ARTS_EFFECT         = 335, //
    LIGHT_ARTS_SKILL         = 336, //
    DARK_ARTS_SKILL          = 337, //
    LIGHT_ARTS_REGEN         = 338, // Regen bonus flat HP amount from Light Arts and Tabula Rasa
    REGEN_DURATION           = 339, //
    HELIX_EFFECT             = 478, //
    HELIX_DURATION           = 477, //
    STORMSURGE_EFFECT        = 400, //
    SUBLIMATION_BONUS        = 401, //
    GRIMOIRE_SPELLCASTING    = 489, // "Grimoire: Reduces spellcasting time" bonus

    // Geo
    CARDINAL_CHANT       = 959,
    CARDINAL_CHANT_BONUS = 1132, // Geomancy galero
    INDI_DURATION        = 960,
    GEOMANCY_BONUS       = 961, // Used to increase potency of "Geomancy +" items (only the highest value is counted)
    WIDENED_COMPASS      = 962,
    MENDING_HALATION     = 968, // This mod should never exceed 1 as the multiplier is the merit, this is basicaly just a bool mod
    RADIAL_ARCANA        = 969,
    CURATIVE_RECANTATION = 970,
    PRIMEVAL_ZEAL        = 971,
    FULL_CIRCLE          = 1025, // Increases the initial multiplier on MP returned via Full Circle
    BOLSTER_EFFECT       = 1028, // Adds bonus duration as +N seconds
    LIFE_CYCLE_EFFECT    = 1029, // Adds bonus HP% returned to the luopan when using Life Cycle
    AURA_SIZE            = 1030, // Used to extend aura size, the formula is 6.25 + (PEntity->getMod(Mod::AURA_SIZE) / 100) so adding 100 will make this 7.25

    ENSPELL           = 341,  // stores the type of enspell active (0 if nothing)
    ENSPELL_DMG       = 343,  // stores the base damage of the enspell before reductions
    ENSPELL_DMG_BONUS = 432,  //
    ENSPELL_CHANCE    = 856,  // Chance of enspell activating (0 = 100%, 10 = 10%, 30 = 30%, ...)
    SPIKES            = 342,  // store the type of spike spell active (0 if nothing)
    SPIKES_DMG        = 344,  // stores the base damage of the spikes before reductions
    SPIKES_DMG_BONUS  = 1079, // Increases Blaze/Ice/Shock spikes damage by percentage (e.g. mod value 50 = +50% spikes damage)

    TP_BONUS    = 345, //
    SAVETP      = 880, // SAVETP Effect for Miser's Roll / ATMA / Hagakure.
    CONSERVE_TP = 944, // Conserve TP trait, random chance between 10 and 200 TP

    // Rune Fencer
    INQUARTATA                  = 963,  // Increases parry rate by a flat %.
    ENHANCES_BATTUTA            = 1004, // Used by RUN merit point cat 2 to add +N% bonus damage to parry spikes during Battuta effect
    ENHANCES_ELEMENTAL_SFORZO   = 1005, // Bonus duration
    ENHANCES_SLEIGHT_OF_SWORD   = 1006, // Used by RUN merit point cat 2 to add +N Subtle Blow to Swordplay
    ENHANCES_INSPIRATION        = 1007, // Used by RUN merit point cat 2 to add +N Fast Cast to Vallation/Valiance
    SWORDPLAY                   = 1008, // Adds bonus starting ticks to Swordplay
    LIEMENT                     = 1009, // Adds bonus duration as +N seconds
    VALIANCE_VALLATION_DURATION = 1010, // Adds bonus duration as +N seconds
    PFLUG                       = 1011, // Adds flat additional all-resist rate in +N%
    VIVACIOUS_PULSE_POTENCY     = 1012, // Adds final HP bonus +N% to calculation of Vivacious Pulse
    AUGMENTS_VIVACIOUS_PULSE    = 1013, // Adds random erase/-na to Vivacious Pulse
    RAYKE_DURATION              = 1014, // Adds bonus duration as +N seconds
    ODYLLIC_SUBTERFUGE_DURATION = 1015, // Adds bonus duration as +N seconds
    SWIPE                       = 1016, // Adds bonus damage to the Swipe/Lunge magic damage calculation
    LIEMENT_DURATION            = 1017, // Adds bonus duration as +N seconds
    GAMBIT_DURATION             = 1018, // Adds bonus duration as +N seconds
    EMBOLDEN_DURATION           = 1019, // Adds bonus duration as +N seconds
    LIEMENT_EXTENDS_TO_AREA     = 1020, // Epeolatry's (RUN Ergon weapon) special effect, makes Liement AoE to party instead of self target only.
    INSPIRATION_FAST_CAST       = 1021, // Inspiration Fast Cast, additive with Fast Cast with a combined cap beyond 80%
    PARRY_SPIKES                = 1022, // Battuta parry spikes rate
    PARRY_SPIKES_DMG            = 1023, // Battuta parry spikes damage
    SPECIAL_ATTACK_EVASION      = 1024, // Foil "Special Attack" evasion
    AUGMENTS_SLEIGHT_OF_SWORD   = 277,  // Enhances bonus "Subtle Blow" per merit.

    FIRE_STAFF_BONUS    = 347,
    ICE_STAFF_BONUS     = 348,
    WIND_STAFF_BONUS    = 349,
    EARTH_STAFF_BONUS   = 350,
    THUNDER_STAFF_BONUS = 351,
    WATER_STAFF_BONUS   = 352,
    LIGHT_STAFF_BONUS   = 353,
    DARK_STAFF_BONUS    = 354,

    FIRE_AFFINITY_PERP    = 553,
    ICE_AFFINITY_PERP     = 554,
    WIND_AFFINITY_PERP    = 555,
    EARTH_AFFINITY_PERP   = 556,
    THUNDER_AFFINITY_PERP = 557,
    WATER_AFFINITY_PERP   = 558,
    LIGHT_AFFINITY_PERP   = 559,
    DARK_AFFINITY_PERP    = 560,

    // Special Modifier+
    ADDS_WEAPONSKILL     = 355, //
    ADDS_WEAPONSKILL_DYN = 356, // In Dynamis

    STEALTH            = 358, //
    SNEAK_DURATION     = 946, // Additional duration in seconds
    INVISIBLE_DURATION = 947, // Additional duration in seconds

    DMG_RATING        = 287, // adds damage rating to weapon (+DMG augments, maneater/blau dolch etc hidden effects)
    MAIN_DMG_RATING   = 366, // adds damage rating to mainhand weapon
    SUB_DMG_RATING    = 367, // adds damage rating to off hand weapon
    RANGED_DMG_RATING = 376, // adds damage rating to ranged weapon
    MAIN_DMG_RANK     = 377, // adds weapon rank to main weapon http://wiki.bluegartr.com/bg/Weapon_Rank
    SUB_DMG_RANK      = 378, // adds weapon rank to sub weapon
    RANGED_DMG_RANK   = 379, // adds weapon rank to ranged weapon

    REGAIN             = 368,  // auto regain TP (from items) | this is multiplied by 10 e.g. 20 is 2% TP
    REGAIN_DOWN        = 406,  // plague, reduce tp
    REFRESH            = 369,  // auto refresh from equipment
    REFRESH_DOWN       = 405,  // plague, reduce mp
    REGEN              = 370,  // auto regen from equipment
    REGEN_DOWN         = 404,  // poison
    CURE_POTENCY       = 374,  // % cure potency | bonus from gear is capped at 50
    CURE_POTENCY_II    = 260,  // % cure potency II | bonus from gear is capped at 30
    CURE_POTENCY_RCVD  = 375,  // % potency of received cure | healer's roll, some items have this
    CURE_POTENCY_BONUS = 1051, // TODO: Increases amount healed by Cure spells (fixed amount)
    DELAYP             = 380,  // delay addition percent (does not affect tp gain)
    RANGED_DELAYP      = 381,  // ranged delay addition percent (does not affect tp gain)

    SHIELD_BASH = 385, //
    KICK_DMG    = 386, // increases kick attack damage
    WEAPON_BASH = 392, //

    WYVERN_BREATH = 402, //

    // Gear set modifiers
    DA_DOUBLE_DMG_RATE       = 408, // Double attack's double damage chance %.
    TA_TRIPLE_DMG_RATE       = 409, // Triple attack's triple damage chance %.
    ZANSHIN_DOUBLE_DAMAGE    = 410, // Zanshin's double damage chance %.
    RAPID_SHOT_DOUBLE_DAMAGE = 479, // Rapid shot's double damage chance %.
    EXTRA_DUAL_WIELD_ATTACK  = 481, // Chance to land an extra attack when dual wielding
    EXTRA_KICK_ATTACK        = 482, // Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
    SAMBA_DOUBLE_DAMAGE      = 415, // Double damage chance when samba is up.
    QUICK_DRAW_TRIPLE_DAMAGE = 417, // Chance to do triple damage with quick draw.
    BAR_ELEMENT_NULL_CHANCE  = 418, // Bar Elemental spells will occasionally NULLify damage of the same element.
    GRIMOIRE_INSTANT_CAST    = 419, // Spells that match your current Arts will occasionally cast instantly, without recast.
    QUAD_ATTACK              = 430, // Quadruple attack chance.

    // Reraise (Auto Reraise, used by gear)
    RERAISE_I   = 456, // Reraise.
    RERAISE_II  = 457, // Reraise II.
    RERAISE_III = 458, // Reraise III.

    ABSORB_DMG_TO_MP = 516, // Unlike PLD gear mod, works on all damage types (Ethereal Earring)

    ITEM_ADDEFFECT_LVADJUST = 278, // level correction factor to use, if any
    ITEM_ADDEFFECT_PLACEHLD = 279, // placeholder, want to keep these together and 99% sure we'll use this
    ITEM_ADDEFFECT_DSTAT    = 280, // value = attacker modifier to use as bonus dmg (mnd, int, etc)
    ITEM_ADDEFFECT_TYPE     = 431, // see procType table in scripts\globals\additional_effects.lua
    ITEM_SUBEFFECT          = 499, // Animation ID of Spikes and Additional Effects
    ITEM_ADDEFFECT_DMG      = 500, // Damage of an items Additional Effect or Spikes
    ITEM_ADDEFFECT_CHANCE   = 501, // Chance of an items Additional Effect or Spikes
    ITEM_ADDEFFECT_ELEMENT  = 950, // Element of the Additional Effect or Spikes, for resist purposes
    ITEM_ADDEFFECT_STATUS   = 951, // Status Effect ID to try to apply via Additional Effect or Spikes
    ITEM_ADDEFFECT_POWER    = 952, // Base Power for effect in MOD_ITEM_ADDEFFECT_STATUS. Must be used for debuffs/buffs.
    ITEM_ADDEFFECT_DURATION = 953, // Base Duration for effect in MOD_ITEM_ADDEFFECT_STATUS

    GOV_CLEARS = 496, // 4% bonus per Grounds of Valor Page clear

    AFTERMATH = 256, // Aftermath ID

    EXTRA_DMG_CHANCE = 506, // Proc rate of OCC_DO_EXTRA_DMG. 111 would be 11.1%
    OCC_DO_EXTRA_DMG = 507, // Multiplier for "Occasionally do x times normal damage". 250 would be 2.5 times damage.

    REM_OCC_DO_DOUBLE_DMG = 863, // Proc rate for REM Aftermaths that apply "Occasionally do double damage"
    REM_OCC_DO_TRIPLE_DMG = 864, // Proc rate for REM Aftermaths that apply "Occasionally do triple damage"

    REM_OCC_DO_DOUBLE_DMG_RANGED = 867, // Ranged attack specific
    REM_OCC_DO_TRIPLE_DMG_RANGED = 868, // Ranged attack specific

    MYTHIC_OCC_ATT_TWICE  = 865, // Proc rate for "Occasionally attacks twice"
    MYTHIC_OCC_ATT_THRICE = 866, // Proc rate for "Occasionally attacks thrice"

    APPRECIATE_GYSAHL_GREENS = 156, // Enhances food effect of Gysahl Greens

    EAT_RAW_FISH    = 412, // Without this, only Mithra can eat raw fish (item cannot be used)
    EAT_RAW_MEAT    = 413, // Without this, only Galka can eat raw meat (item cannot be used)
    DRINK_DISTILLED = 159, // Without this, Distilled Water cannot be consumed (item can still be used)

    EQUIPMENT_ONLY_RACE = 276, // An 8-bit flag that denotes that only a certain race(s) can use this equipment (0 means all races can use)

    ENHANCES_CURSNA_RCVD     = 67,   // Potency of "Cursna" effects received
    ENHANCES_CURSNA          = 310,  // Used by gear with the "Enhances Cursna" or "Cursna+" attribute
    ENHANCES_HOLYWATER       = 495,  // Used by gear with the "Enhances Holy Water" or "Holy Water+" attribute
    ENHANCES_PROT_SHELL_RCVD = 977,  // Enhances Protect and Shell Effects Received (Binary MOD)
    ENHANCES_PROT_RCVD       = 1050, // TODO: Enhances Protect Received (Percent)

    RETALIATION = 414, // Increases damage of Retaliation hits

    CLAMMING_IMPROVED_RESULTS  = 509, //
    CLAMMING_REDUCED_INCIDENTS = 510, //

    CHOCOBO_RIDING_TIME = 511, // Increases chocobo riding time

    HARVESTING_RESULT = 513, // Improves harvesting results
    LOGGING_RESULT    = 514, // Improves logging results
    MINING_RESULT     = 515, // Improves mining results

    EGGHELM = 517,

    SHIELDBLOCKRATE           = 518, // Affects shield block rate, percent based
    DIA_DOT                   = 313, // Increases the DoT damage of Dia
    ENH_DRAIN_ASPIR           = 315, // % damage boost to Drain and Aspir
    AUGMENTS_ABSORB_LIBERATOR = 521, // Direct Absorb spell increase while Liberator is equipped (percentage based) (Augments "Absorb" spells)
    AMMO_SWING                = 523, // Follow-up swing rate w/ virtue stone ammo (Jailer weapons). Does nothing for non-players.
    AUGMENTS_CONVERT          = 525, // Convert HP to MP Ratio Multiplier. Value = MP multiplier rate.
    AUGMENTS_SA               = 526, // Adds Critical Attack Bonus to Sneak Attack, percentage based.
    AUGMENTS_TA               = 527, // Adds Critical Attack Bonus to Trick Attack, percentage based.
    AUGMENTS_FEINT            = 502, // Feint will give another -10 Evasion per merit level
    AUGMENTS_ASSASSINS_CHARGE = 886, // Gives Assassin's Charge +1% Critical Hit Rate per merit level
    AUGMENTS_AMBUSH           = 887, // Gives +1% Triple Attack per merit level when Ambush conditions are met
    AUGMENTS_AURA_STEAL       = 889, // 20% chance of 2 effects to be dispelled or stolen per merit level
    AUGMENTS_CONSPIRATOR      = 912, // Applies Conspirator benefits to player at the top of the hate list
    ENHANCES_REFRESH          = 529, // "Enhances Refresh" adds +1 per modifier to spell's tick result.
    NO_SPELL_MP_DEPLETION     = 530, // % to not deplete MP on spellcast.
    STONESKIN_BONUS_HP        = 539, // Bonus "HP" granted to Stoneskin spell.
    DAY_NUKE_BONUS            = 565, // Bonus damage from "Elemental magic affected by day" (Sorc. Tonban)
    IRIDESCENCE               = 566, // Iridescence trait (additional weather damage/penalty)
    BARSPELL_AMOUNT           = 567, // Additional elemental resistance granted by bar- spells
    BARSPELL_MDEF_BONUS       = 827, // Extra magic defense bonus granted to the bar- spell effect
    RAPTURE_AMOUNT            = 568, // Bonus amount added to Rapture effect
    EBULLIENCE_AMOUNT         = 569, // Bonus amount added to Ebullience effect
    AQUAVEIL_COUNT            = 832, // Modifies the amount of hits that Aquaveil absorbs before being removed
    ENH_MAGIC_DURATION        = 890, // Enhancing Magic Duration increase %
    ENHANCES_COURSERS_ROLL    = 891, // Courser's Roll Bonus % chance
    ENHANCES_CASTERS_ROLL     = 892, // Caster's Roll Bonus % chance
    ENHANCES_BLITZERS_ROLL    = 893, // Blitzer's Roll Bonus % chance
    ENHANCES_ALLIES_ROLL      = 894, // Allies' Roll Bonus % chance
    ENHANCES_TACTICIANS_ROLL  = 895, // Tactician's Roll Bonus % chance
    OCCULT_ACUMEN             = 902, // Grants bonus TP when dealing damage with elemental or dark magic

    QUICK_MAGIC = 909, // Percent chance spells cast instantly (also reduces recast to 0, similar to Chainspell)

    // Crafting food effects
    SYNTH_SUCCESS_RATE              = 851,  // Success rate bonus (percent) for all synths except desynths.
    SYNTH_SUCCESS_RATE_DESYNTHESIS  = 916,  // Success rate bonus (percent) for desynths, specifically.
    SYNTH_SUCCESS_RATE_WOODWORKING  = 1098, // Success rate bonus (percent) for Woodworking, specifically.
    SYNTH_SUCCESS_RATE_SMITHING     = 1099, // Success rate bonus (percent) for Smithing, specifically.
    SYNTH_SUCCESS_RATE_GOLDSMITHING = 1100, // Success rate bonus (percent) for Goldsmithing, specifically.
    SYNTH_SUCCESS_RATE_CLOTHCRAFT   = 1101, // Success rate bonus (percent) for Clothcraft, specifically.
    SYNTH_SUCCESS_RATE_LEATHERCRAFT = 1102, // Success rate bonus (percent) for Leahercraft, specifically.
    SYNTH_SUCCESS_RATE_BONECRAFT    = 1103, // Success rate bonus (percent) for Bonecraft, specifically.
    SYNTH_SUCCESS_RATE_ALCHEMY      = 1104, // Success rate bonus (percent) for Alchemy, specifically.
    SYNTH_SUCCESS_RATE_COOKING      = 1105, // Success rate bonus (percent) for Cooking, specifically.

    SYNTH_SKILL_GAIN = 852, // Synthesis skill gain rate

    SYNTH_SPEED_WOODWORKING  = 1106, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_SMITHING     = 1107, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_GOLDSMITHING = 1108, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_CLOTHCRAFT   = 1109, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_LEATHERCRAFT = 1110, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_BONECRAFT    = 1111, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_ALCHEMY      = 1112, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)
    SYNTH_SPEED_COOKING      = 1113, // Escutcheon (Phase 3 & 4). Bonus to synth speed (Makes process faster. Assuming miliseconds)

    SYNTH_ANTI_NQ_WOODWORKING  = 1114, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_SMITHING     = 1115, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_GOLDSMITHING = 1116, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_CLOTHCRAFT   = 1117, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_LEATHERCRAFT = 1118, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_BONECRAFT    = 1119, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_ALCHEMY      = 1120, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.
    SYNTH_ANTI_NQ_COOKING      = 1121, // Escutcheon (Phase 4) "Artisanal Knowledge" Enchantment. Prevents NQ results, making them fails.

    SYNTH_ANTI_HQ_WOODWORKING  = 144, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_SMITHING     = 145, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_GOLDSMITHING = 146, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_CLOTHCRAFT   = 147, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_LEATHERCRAFT = 148, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_BONECRAFT    = 149, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_ALCHEMY      = 150, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.
    SYNTH_ANTI_HQ_COOKING      = 151, // Craft Rings. They ONLY prevent their associated skill type HQs, even if item description doesn't state it.

    SYNTH_HQ_RATE              = 862,  // High-quality success rate (not a percent)
    SYNTH_HQ_RATE_WOODWORKING  = 1122, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_SMITHING     = 1123, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_GOLDSMITHING = 1124, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_CLOTHCRAFT   = 1125, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_LEATHERCRAFT = 1126, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_BONECRAFT    = 1127, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_ALCHEMY      = 1128, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.
    SYNTH_HQ_RATE_COOKING      = 1129, // High-quality success rate (not a percent) for specific skill. Used by Escutcheon's enchantment.

    SYNTH_MATERIAL_LOSS              = 861, // Material loss rate (percent) for all synths.
    SYNTH_MATERIAL_LOSS_WOODWORKING  = 925, // Material loss rate (percent) when doing woodworking
    SYNTH_MATERIAL_LOSS_SMITHING     = 926, // Material loss rate (percent) when doing smithing
    SYNTH_MATERIAL_LOSS_GOLDSMITHING = 927, // Material loss rate (percent) when doing goldsmithing
    SYNTH_MATERIAL_LOSS_CLOTHCRAFT   = 928, // Material loss rate (percent) when doing clothcraft
    SYNTH_MATERIAL_LOSS_LEATHERCRAFT = 929, // Material loss rate (percent) when doing leathercraft
    SYNTH_MATERIAL_LOSS_BONECRAFT    = 930, // Material loss rate (percent) when doing bonecraft
    SYNTH_MATERIAL_LOSS_ALCHEMY      = 931, // Material loss rate (percent) when doing alchemy
    SYNTH_MATERIAL_LOSS_COOKING      = 932, // Material loss rate (percent) when doing cooking
    SYNTH_MATERIAL_LOSS_FIRE         = 917, // Material loss rate (percent) when using a fire crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_ICE          = 918, // Material loss rate (percent) when using a ice crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_WIND         = 919, // Material loss rate (percent) when using a wind crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_EARTH        = 920, // Material loss rate (percent) when using a earth crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_THUNDER      = 921, // Material loss rate (percent) when using a lightning crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_WATER        = 922, // Material loss rate (percent) when using a water crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_LIGHT        = 923, // Material loss rate (percent) when using a light crystal (or HQ version)
    SYNTH_MATERIAL_LOSS_DARK         = 924, // Material loss rate (percent) when using a dark crystal (or HQ version)

    // Weaponskill %damage modifiers
    // The following modifier should not ever be set, but %damage modifiers to weaponskills use the next 255 IDs (this modifier + the WSID)
    // For example, +10% damage to Chant du Cygne would be ID 570 + 225 (795)
    WEAPONSKILL_DAMAGE_BASE = 570,

    ALL_WSDMG_ALL_HITS = 840,  // Generic (all Weaponskills) damage, on all hits.
                               // Per https://www.bg-wiki.com/bg/Weapon_Skill_Damage we need all 3..
    ALL_WSDMG_FIRST_HIT = 841, // Generic (all Weaponskills) damage, first hit only.
    WS_NO_DEPLETE       = 949, // % chance a Weaponskill depletes no TP.
    WS_STR_BONUS        = 980, // % bonus to str_wsc.
    WS_DEX_BONUS        = 957, // % bonus to dex_wsc.
    WS_VIT_BONUS        = 981, // % bonus to vit_wsc.
    WS_AGI_BONUS        = 982, // % bonus to agi_wsc.
    WS_INT_BONUS        = 983, // % bonus to int_wsc.
    WS_MND_BONUS        = 984, // % bonus to mnd_wsc.
    WS_CHR_BONUS        = 985, // % bonus to chr_wsc.

    // Pet Modifiers (Job Point Gifts)
    PET_ATK_DEF    = 990, // Increases pet physical attack, ranged attack, and physical defense
    PET_ACC_EVA    = 991, // Increases pet physical accuracy, ranged accuracy, and evasion
    PET_MAB_MDB    = 992, // Increases pet magic attack and magic defense
    PET_MACC_MEVA  = 993, // Increases pet magic accuracy and evasion
    PET_ATTR_BONUS = 994, // Increases pet attributes
    PET_TP_BONUS   = 995, // Increases pet TP bonus

    EXPERIENCE_RETAINED   = 914, // Experience points retained upon death (this is a percentage)
    CAPACITY_BONUS        = 915, // Capacity point bonus granted
    CONQUEST_BONUS        = 933, // Conquest points bonus granted (percentage)
    CONQUEST_REGION_BONUS = 934, // Increases the influence points awarded to the player's nation when receiving conquest points
    CAMPAIGN_BONUS        = 935, // Increases the evaluation for allied forces by percentage

    SUBTLE_BLOW_II       = 973, // Subtle Blow II Effect (Cap 50%) Total Effect (SB + SB_II cap 75%)
    GARDENING_WILT_BONUS = 975, // Increases the number of Vanadays a plant can survive before it wilts

    SUPERIOR_LEVEL  = 997, // SU0..5
    ONE_HOUR_RECAST = 996, // Decreases the recast time of one-hour abilities by n minutes.

    // AF3 Set Bonus Modifiers
    AUGMENT_CONSERVE_MP    = 1031, // Percent chance to deal extra damage based on Conserve MP Amount (BLM AF3 Sets)
    AUGMENT_COMPOSURE      = 1032, // Percent Enhancing Duration Extension for Others (RDM AF3 Sets)
    AUGMENT_DAMAGE_HP      = 1033, // Percent chance to increase damage based on player HP% (DRK AF3 Sets)
    AUGMENT_DAMAGE_PET_HP  = 1034, // Percent chance to increase damage based on pet HP% (BST/DRG AF3 Sets)
    AUGMENT_BLOOD_BOON     = 1035, // Percent chance to deal extra damage based on Blood Boon Amount (SMN AF3 Sets)
    AUGMENT_BLU_MAGIC      = 1036, // Percent chance for BLU magic to receive 3x WSC value for spell (BLU AF3 Sets)
    GEOMANCY_MP_NO_DEPLETE = 1037, // Percent chance for Geomancy to cost 0 MP (GEO AF3 Sets)

    DIG_BYPASS_FATIGUE = 1074, // Chocobo digging modifier found in "Blue Race Silks". Modifier works as a direct percent.
    DIG_RARE_ABILITY   = 1133, // Chocobo digging modifier found in "Black Chocobo Suit" and "Denim Pants +1".
    BREATH_DMG_DEALT   = 1075, // Breath damage dealt

    DAMAGE_LIMIT  = 1080, // Damage Limit increase, found on some traits. It's a flat value added to max pDIF (maxpDIF + DL/100) https://www.bg-wiki.com/ffxi/Damage_Limit%2B
    DAMAGE_LIMITP = 1081, // Damage Limit +% increase, found on some gear. It's a multiplier added after flat Damage Limit ((maxpDIF + DL/100)*(100 + DLP/100)/100) https://www.ffxiah.com/forum/topic/56649/physical-damage-limit/

    MAGIC_BURST_BONUS_CAPPED   = 487, // Magic Burst Bonus I from gear, Ancient Magic Merits, Innin merits and Atmas. Cap at 40% bonus (1.4 multiplier)
    MAGIC_BURST_BONUS_UNCAPPED = 274, // Magic Burst Bonus II from gear, JP Gifts, BLM JPs and Job traits. No known cap.

    DESPAWN_TIME_REDUCTION = 1134, // Reduction in seconds. 1 = 1 second less to despawn.

    PARRY_HP_RECOVERY = 1135, // Recover <Mod Value> HP on successful parry.

    // TODO: These mods are not yet implemented.
    REWARD_RECAST = 1152, // TODO: Reward recast time reduction (seconds)

    // IF YOU ADD ANY NEW MODIFIER HERE, ADD IT IN scripts/enum/mod.lua ASWELL!

    // The spares take care of finding the next ID to use so long as we don't forget to list IDs that have been freed up by refactoring.
    // 570 through 825 used by WS DMG mods these are not spares.
    //
    // SPARE IDs: 1157 and onward
};

// temporary workaround for using enum class as unordered_map key until compilers support it
struct EnumClassHash
{
    template <typename T>
    std::size_t operator()(T t) const
    {
        return static_cast<std::size_t>(t);
    }
};

/************************************************************************
 *  Modifier Class                                                       *
 ************************************************************************/

class CModifier
{
public:
    Mod   getModID() const;
    int16 getModAmount() const;

    void setModAmount(int16 amount);

    CModifier(Mod type, int16 amount = 0);

private:
    Mod   m_id{ Mod::NONE };
    int16 m_amount{ 0 };
};

enum class PetModType
{
    All        = 0,
    Avatar     = 1,
    Wyvern     = 2,
    Automaton  = 3,
    Harlequin  = 4,
    Valoredge  = 5,
    Sharpshot  = 6,
    Stormwaker = 7,
    Luopan     = 8
};

class CPetModifier : public CModifier
{
public:
    CPetModifier(Mod type, PetModType pettype, int16 amount = 0);
    PetModType getPetModType() const;

private:
    PetModType m_pettype{ PetModType::All };
};

#endif
