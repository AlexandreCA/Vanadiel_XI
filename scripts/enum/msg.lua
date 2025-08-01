-----------------------------------
-- This file holds all global (not zone specific) text references
-----------------------------------
xi = xi or {}
xi.msg = xi.msg or {}

-----------------------------------
-- Message Channels
-----------------------------------

---@enum xi.channel
xi.msg.channel =
{
    SAY           = 0,
    SHOUT         = 1,
    TELL          = 3,
    PARTY         = 4,
    LINKSHELL     = 5,
    SYSTEM_1      = 6, -- Standard "printToPlayer" default if no type specified
    SYSTEM_2      = 7, -- Login / world announcement messages
    EMOTION       = 8,
    -- 9 / 10 / 11 = Does not work / nothing
    GM_PROMPT     = 12, -- Menu prompt from GM
    NS_SAY        = 13, -- Same as MESSAGE_SAY but has no speaker object displayed
    NS_SHOUT      = 14, -- Same as MESSAGE_SHOUT but has no speaker object displayed
    NS_PARTY      = 15, -- Same as MESSAGE_PARTY but has no speaker object displayed
    NS_LINKSHELL  = 16, -- Same as MESSAGE_LINKSHELL but has no speaker object displayed
    UNKNOWN_17    = 17, -- 17 through 25 appear to repeat the effects of other values
    UNKNOWN_18    = 18,
    UNKNOWN_19    = 19,
    UNKNOWN_20    = 20,
    UNKNOWN_21    = 21,
    UNKNOWN_22    = 22,
    UNKNOWN_23    = 23,
    UNKNOWN_24    = 24,
    UNKNOWN_25    = 25,
    YELL          = 26,
    LINKSHELL2    = 27, -- Second LS color. Default is Green
    NS_LINKSHELL2 = 28, -- Same as LINKSHELL_2 but has but has no speaker object displayed
    SYSTEM_3      = 29, -- "Basic system messages" in config menu. Yellow by default.
    LINKSHELL3    = 30, -- Yes really it looks like a 3rd LS may have been planned at some point.
    NS_LINKSHELL3 = 31, -- (assumed as it follows pattern and color)
    UNKNOWN_32    = 32, -- Looks the same as 31
    UNITY         = 33,
    JP_ASSIST     = 34,
    NA_ASSIST     = 35,
}

-- used by player:printToArea
---@enum xi.area
xi.msg.area =
{
    SYSTEM = 0, -- Server wide like the purple stuff :)
    SAY    = 1, -- Will display in small area around player
    SHOUT  = 2, -- Will display in wide area around player
    PARTY  = 3, -- Will display to players entire party/alliance
    YELL   = 4, -- If yell is enabled in zone, will display.
    UNITY  = 5, -- Also World Wide
}

-----------------------------------
-- Basic Messages
-----------------------------------

---@enum xi.basic
xi.msg.basic =
{
    NONE                            = 0,  -- Display nothing
    HIT_DMG                         = 1,  -- <actor> hits <target> for <amount> points of damage.
    HIT_MISS                        = 15, -- <actor> misses <target>.
    HIT_CRIT                        = 67, -- <actor> scores a critical hit! <target> takes <amount> points of damage.

    -- Magic
    MAGIC_DMG                       = 2,   -- <caster> casts <spell>. <target> takes <amount> damage.
    MAGIC_RECOVERS_HP               = 7,   -- <caster> casts <spell>. <target> recovers <amount> HP.
    MAGIC_UNABLE_TO_CAST            = 17,  -- Unable to cast spells at this time.
    MAGIC_UNABLE_TO_CAST_2          = 18,  -- Unable to cast spells at this time.
    MAGIC_CANNOT_CAST               = 47,  -- <caster> cannot cast <spell>.
    MAGIC_CANNOT_BE_CAST            = 48,  -- <spell> cannot be cast on <target>. (example: tractor)
    MAGIC_NO_EFFECT                 = 75,  -- <caster>'s <spell> has no effect on <target>.
    MAGIC_REMOVE_EFFECT             = 83,  -- <caster> casts <spell>. <caster> successfully removes <target>'s <status>.
    MAGIC_RESIST                    = 85,  -- <caster> casts <spell>. <target> resists the spell.
    MAGIC_TELEPORT                  = 93,  -- <caster> casts <spell>. <target> vanishes.
    MAGIC_FAIL                      = 114, -- <caster> casts <spell> on <target>, but the spell fails to take effect
    MAGIC_DRAIN_HP                  = 227, -- <caster> casts <spell>. <amount> HP drained from <target>.
    MAGIC_DRAIN_MP                  = 228, -- <caster> casts <spell>. <amount> MP drained from <target>.
    MAGIC_GAIN_EFFECT               = 230, -- <caster> casts <spell>. <target> gains the effect of <status>.
    MAGIC_ENFEEB_IS                 = 236, -- <caster> casts <spell>. <target> is <status>.
    MAGIC_ENFEEB                    = 237, -- <caster> casts <spell>. <target> receives the effect of <status>.
    MAGIC_BURST_DAMAGE              = 252, -- <caster> casts <spell> Magic burst! <target> takes <amount> points of damage.
    MAGIC_BURST_ENFEEB              = 268, -- <caster> casts <spell> Magic burst! <target> receives the effect of <status>.
    MAGIC_BURST_ENFEEB_IS           = 271, -- <caster> casts <spell> Magic burst! <target> is <status>.
    MAGIC_RESIST_2                  = 284, -- <target> resists the effects of the spell!
    MAGIC_CASTS_ON                  = 309, -- <caster> casts <spell> on <target>.
    MAGIC_ABSORB_STR                = 329, -- <caster> casts <spell>. <target>'s STR is drained.
    MAGIC_ABSORB_DEX                = 330, -- <caster> casts <spell>. <target>'s DEX is drained.
    MAGIC_ABSORB_VIT                = 331, -- <caster> casts <spell>. <target>'s VIT is drained.
    MAGIC_ABSORB_AGI                = 332, -- <caster> casts <spell>. <target>'s AGI is drained.
    MAGIC_ABSORB_INT                = 333, -- <caster> casts <spell>. <target>'s INT is drained.
    MAGIC_ABSORB_MND                = 334, -- <caster> casts <spell>. <target>'s MND is drained.
    MAGIC_ABSORB_CHR                = 335, -- <caster> casts <spell>. <target>'s CHR is drained.
    MAGIC_ERASE                     = 341, -- <caster> casts <spell>. <target>'s <status> effect disappears!
    MAGIC_STEAL                     = 430, -- <caster> casts <spell>. <number> of <target>'s effects is drained.
    MAGIC_TP_REDUCE                 = 431, -- <caster> casts <spell>. <target>'s TP is reduced.
    MAGIC_ABSORB_TP                 = 454, -- <caster> casts <spell>. <amount> TP drained from <target>.
    MAGIC_ABSORB_ACC                = 533, -- <caster> casts <spell>. <target>'s Accuracy is drained.
    MAGIC_REMOVE_EFFECT_2           = 571, -- <number> of <target>'s status ailments disappear!
    MAGIC_ABSORB_AILMENT            = 572, -- <caster> casts <spell>. <caster> absorbs <number> of <target>'s status ailments.
    MAGIC_MUST_ASTRAL_FLOW          = 581, -- Unable to cast <spell>. Astral Flow must be in effect to cast this spell.
    MAGIC_COMPLETE_RESIST           = 655, -- <caster> casts <spell>. <target> completely resists the spell.

    -- Weaponskill / Mobskill (0-255 WS, 256+ monster skill)
    SKILL_RECOVERS_HP               = 103, -- The <player> uses .. <target> recovers .. HP.
    SKILL_ENFEEB_2                  = 142, -- <user> uses <skill>. <target> receives the effect of <status> and <status>.
    SKILL_ERASE                     = 159, -- <user> uses <skill> <target>'s <status> effect disappears!
    DAMAGE                          = 185, -- player uses, target takes 10 damage. DEFAULT
    SKILL_GAIN_EFFECT               = 186, -- <user> uses <skill>. <target> gains the effect of <status>.
    SKILL_DRAIN_HP                  = 187, -- <user> uses <skill>. <amount> HP drained from <target>
    SKILL_MISS                      = 188, -- <user> uses <skill>, but misses <target>.
    SKILL_NO_EFFECT                 = 189, -- <user> uses <skill>. No effect on <target>.
    SKILL_RECOVERS_MP               = 224, -- <user> uses <skill>. <target> recovers <amount> MP.
    SKILL_DRAIN_MP                  = 225, -- <user> uses <skill>. <amount> MP drained from <target>
    SKILL_DRAIN_TP                  = 226, -- <user> uses <skill>. <amount> TP drained from <target>
    SELF_HEAL                       = 238, -- <user> uses <skill>. <user> recovers <amount> HP.
    SKILL_ENFEEB_IS                 = 242, -- <user> uses <skill>. <target> is <status>.
    SKILL_ENFEEB                    = 243, -- <user> uses <skill>. <target> receives the effect of <status>.
    SELF_HEAL_SECONDARY             = 263, -- <target> recovers <amount> HP.
    DAMAGE_SECONDARY                = 264, -- <target> takes <amount> points of damage.
    SKILL_GAIN_EFFECT_2             = 319, -- <user> uses <skill>. <target> gains the effect of <status>.
    RANGED_ATTACK_HIT               = 352, -- <user> ranged attack hits <target> for <amount> points of damage.
    RANGED_ATTACK_CRIT              = 353, -- <user> ranged attack scores a critical hit! \n <target> takes <amount> points of damage.
    RANGED_ATTACK_MISS              = 354, -- <user> ranged attack misses.
    RANGED_ATTACK_NO_EFFECT         = 355, -- <user> ranged attack has no effect on <target>.
    RANGED_ATTACK_SQUARELY          = 576, -- <user> ranged attack hits the <target> squarely for <amount> points of damage.,
    RANGED_ATTACK_PUMMELS           = 577, -- <user> ranged attack strikes true, pummeling <target> for <amount> points of damage!,
    AOE_REGAIN_HP                   = 357, -- <target> regains <amount> HP.
    AOE_REGAIN_MP                   = 358, -- <target> regains <amount> MP.
    ABILITIES_RECHARGED             = 360, -- <user> uses <skill>. All of <target>'s abilities are recharged.

    -- Job Ability messages
    USES_JA                         = 100, -- The <player> uses ..
    USES                            = 101, -- The <entity> uses ..
    JA_RECOVERS_HP                  = 102, -- The <player> uses .. <target> recovers .. HP.
    ACC_EVA_DOWN                    = 144, -- <user> uses <ability>. <target> receives the effect of Accuracy Down and Evasion Down.
    ACC_EVA_BOOST                   = 146, -- <user> uses <ability>. <target> receives the effect of Accuracy Boost and Evasion Boost.
    ACC_EVA_BOOST_2                 = 147, -- <target> receives the effect of Accuracy Boost and Evasion Boost.
    JA_RECOVERS_HP_2                = 318, -- <user> uses ability. <target> recovers <amount> HP. -- Observed on healing breath.
    JA_DAMAGE                       = 110, -- <user> uses <ability>. <target> takes <amount> damage.
    JA_REMOVE_EFFECT                = 123, -- <user> uses <ability>. <user> successfully removes <target>'s <status>.
    JA_ENFEEB_IS                    = 127, -- <user> uses <ability>. <target> is <status>.
    JA_NO_EFFECT                    = 156, -- <user> uses <ability>. No effect on <target>. (1 line msg)
    JA_MISS                         = 158, -- <user> uses <ability>, but misses. (no name included)
    USES_JA_TAKE_DAMAGE             = 317, -- The <player> uses .. <target> takes .. points of damage.
    JA_GAIN_EFFECT                  = 266, -- <target> gains the effect of <ability>.
    JA_RECEIVES_EFFECT              = 267, -- <target> receives the effect of <status>.
    JA_GAIN_EFFECT_2                = 316, -- <user> uses <ability>. <target> gains the effect of <effect>.
    JA_RECEIVES_EFFECT_2            = 320, -- <user> uses <ability>. <target> receives the effect of <status>.
    JA_RECEIVES_MAB_MDB             = 415, -- <user> uses <ability>. <target> receives the effect of Magic Attack Boost and Magic Defense Boost.
    JA_RECEIVES_MAB_MDB_2           = 414, -- <target> receives the effect of Magic Attack Boost and Magic Defense Boost.
    JA_REMOVE_EFFECT_2              = 321, -- <user> uses <ability>. <target>'s <status> wears off.
    JA_NO_EFFECT_2                  = 323, -- <user> uses <ability>. No effect on <target>. (2 line msg)
    JA_MISS_2                       = 324, -- <user> uses <ability>, but misses <target>. (includes target name)
    JA_RECEIVES_EFFECT_3            = 441, -- <user> receives the effect of <ability>.
    JA_RECOVERS_MP                  = 451, -- <user> uses <ability>. <target> regains <amount> MP.
    JA_ATK_ENHANCED                 = 285, -- <target>'s attacks are enhanced.
    STATUS_BOOST                    = 364, -- <user> uses <ability>. All of <target>'s status parameters are boosted.
    STATUS_BOOST_2                  = 365, -- All of <target>'s status parameters are boosted.
    JA_MAGIC_BURST                  = 379, -- <user> uses <ability>. Magic Burst! the <target> takes <amount> damage.
    JA_ENMITY_DECREASE              = 743, -- <user> uses <ability>. <target>'s enmity decreases.
    JA_TH_EFFECTIVENESS             = 608, -- <user> uses <ability>. Treasure Hunter effectiveness against <target> increases to <amount>.

    -- "Fortified against" messages
    FORTIFIED_DEMONS                = 149, -- <target> is fortified against demons.
    FORTIFIED_DRAGONS               = 151, -- <target> is fortified against dragons.
    FORTIFIED_UNDEAD                = 286, -- <target> is fortified against undead.
    FORTIFIED_ARCANA                = 287, -- <target> is fortified against arcana.

    -- Misc Other
    DEFEATS_TARG                    = 6,   -- The <player> defeats <target>.
    ALREADY_CLAIMED                 = 12,  -- Cannot attack. Your target is already claimed.
    IS_INTERRUPTED                  = 16,  -- The <player>'s casting is interrupted.
    FALL_TO_GROUND                  = 20,  -- <name> falls to the ground.
    IS_PARALYZED                    = 29,  -- The <player> is paralyzed.
    ANTICIPATE                      = 30,  -- <target> anticipates the attack.
    SHADOW_ABSORB                   = 31,  -- .. of <target>'s shadows absorb the damage and disappear.
    NOT_ENOUGH_MP                   = 34,  -- The <player> does not have enough MP to cast (NULL).
    NO_NINJA_TOOLS                  = 35,  -- The <player> lacks the ninja tools to cast (NULL).
    UNABLE_TO_CAST_SPELLS           = 49,  -- The <player> is unable to cast spells.
    SKILL_REACHES_LEVEL             = 53,  -- <target>'s <skill> skill reaches level <level>.
    CANNOT_PERFORM                  = 71,  -- The <player> cannot perform that action.
    CANNOT_PERFORM_TARG             = 72,  -- That action cannot be performed on <target>.
    UNABLE_TO_USE_JA                = 87,  -- Unable to use job ability.
    UNABLE_TO_USE_JA2               = 88,  -- Unable to use job ability.
    WAIT_LONGER                     = 94,  -- You must wait longer to perform that action.
    IS_INTIMIDATED                  = 106, -- The <player> is intimidated by <target>'s presence.
    FAMILIAR_PC                     = 108, -- The <player> uses .. Pet's powers increase!
    FAMILIAR_MOB                    = 109, -- The <mob> uses .. Pet's powers increase!
    STEAL_SUCCESS                   = 125, -- <user> uses <ability>. <user> steals <item> from <target>.
    MUG_SUCCESS                     = 129, -- <user> uses <ability>. <user> mugs <amount> gil from <target>.
    STEAL_FAIL                      = 153, -- <user> uses <ability>. <user> fails to steal from <target>.
    CANNOT_ON_THAT_TARG             = 155, -- You cannot perform that action on the specified target.
    REQUIRES_SHIELD                 = 199, -- That action requires a shield.
    DISAPPEAR_NUM                   = 231, -- <num> of <target>'s effects disappear!
    DRAWN_IN                        = 232, -- <target> is drawn in.
    MUG_FAIL                        = 244, -- <user> fails to mug <target>.
    IS_EFFECT                       = 277, -- "is <status>" - that's the entire message.
    EVADES                          = 282, -- <target> evades.
    NO_EFFECT                       = 283, -- "No effect" - that's the entire message.
    NEEDS_2H_WEAPON                 = 307, -- That action requires a two-handed weapon.
    LEVEL_IS_RESTRICTED             = 314, -- <target>'s level is currently restricted to <number>. Equipment affected by the level restriction will be adjusted accordingly.
    CANT_BE_USED_IN_AREA            = 316, -- That action cannot be used in this area.
    CANT_HEAL_WITH_AVATAR           = 345, -- You cannot heal while you have an avatar summoned.
    FULL_INVENTORY                  = 356, -- Cannot execute command. Your inventory is full.
    NARROWLY_ESCAPE                 = 359, -- <name> narrowly escapes impending doom.
    TP_REDUCED                      = 362, -- tp reduced to
    AOE_HP_RECOVERY                 = 367, -- <target> recovers <amount> HP.
    ATTR_DRAINED                    = 369, -- <user> uses <ability>. <amount> of <target>'s attributes is drained.
    EFFECT_DRAINED                  = 370, -- <num> status effects are drained from <target>.
    TP_INCREASE                     = 409, -- <user> uses <ability>. <target>'s TP is increased to <amount>.
    CANNOT_ATTACK_TARGET            = 446, -- You cannot attack that target
    STEAL_EFFECT                    = 453, -- <user> uses <ability>. <user> steals the effect of <status> from <target>.
    REQUIRES_COMBAT                 = 525, -- .. can only be performed during battle.
    STATUS_PREVENTS                 = 569, -- Your current status prevents you from using that ability.
    OBTAINED_KEY_ITEM               = 758, -- Obtained key item: <key item>.
    ALREADY_HAVE_KEY_ITEM           = 759, -- You already have key item: <key item>.

    -- Distance
    TARG_OUT_OF_RANGE               = 4,  -- <target> is out of range.
    UNABLE_TO_SEE_TARG              = 5,  -- Unable to see <target>.
    LOSE_SIGHT                      = 36, -- You lose sight of <target>.
    TOO_FAR_AWAY                    = 78, -- <target> is too far away.

    -- Weaponskills
    READIES_WS                      = 43,  -- <actor> readies <weapon_skill>.
    CANNOT_USE_WS                   = 190, -- The <player> cannot use that weapon ability.
    NOT_ENOUGH_TP                   = 192, -- The <player> does not have enough TP.

    -- Pets
    REQUIRES_A_PET                  = 215, -- That action requires a pet.
    THAT_SOMEONES_PET               = 235, -- That is someone's pet.
    ALREADY_HAS_A_PET               = 315, -- The <player> already has a pet.
    NO_EFFECT_ON_PET                = 336, -- No effect on that pet.
    NO_JUG_PET_ITEM                 = 337, -- You do not have the necessary item equipped to call a beast.
    MUST_HAVE_FOOD                  = 347, -- You must have pet food equipped to use that command.
    STATUS_INCREASED                = 562, -- The status parameters of <target> have increased.
    PET_CANNOT_DO_ACTION            = 574, -- <player>'s pet is currently unable to perform that action.
    PET_NOT_ENOUGH_TP               = 575, -- <player>'s pet does not have enough TP to perform that action.
    SPIRIT_BOND                     = 800, -- Spirit Bond Activates. <Player> takes <number> points of damage. -- Wyvern Spirit bond

    -- Food
    IS_FULL                         = 246, -- <target> is full.
    CANNOT_EAT                      = 247, -- <actor> can't eat the <item>.
    EATS_FINDS_ITEM                 = 600, -- <actor> eats a <item>.<br><actor> finds a <item2> inside!
    EATS_FINDS_NOTHING              = 604, -- <actor> eats a <item>, but finds nothing inside...

    -- Items
    ITEM_USES                       = 28,  -- <actor> uses a <item>.
    ITEM_UNABLE_TO_USE              = 55,  -- Unable to use item.
    ITEM_UNABLE_TO_USE_2            = 56,  -- Unable to use item.
    ITEM_FAILS_TO_ACTIVATE          = 62,  -- The <item> fails to activate.
    ITEM_NO_PETRAS                  = 65,  -- You are not carrying any Petras.<br>You cannot use the <item>.
    ITEM_DOES_NOT_HAVE              = 91,  -- <actor> does not have any <item>.
    ITEM_CANNOT_USE_ON              = 92,  -- Cannot use the <item> on <target>.
    ITEM_CANNOT_USE_TARGET          = 517, -- The <item> cannot bed used on that target.
    ITEM_YOU_OBTAIN_FROM            = 98,  -- You obtain a <item> from <target>.
    ITEM_NO_USE_LEVEL               = 104, -- Unable to use item.<br>You do not meet the level requirement.
    ITEM_NO_USE_MEDICATED           = 111, -- You cannot use <item> while medicated.
    ITEM_NO_USE_INVENTORY           = 308, -- Unable to use the <item>.<br><target>'s inventory is full.
    ITEM_RECEIVES_EFFECT            = 375, -- <actor> uses a <item>.<br><target> receives the effect of <status>.
    ITEM_OBTAINS_A                  = 376, -- <actor> uses a <item>.<br><target> obtains a <item2>.
    ITEM_OBTAINS                    = 377, -- <actor> uses a <item>.<br><target> obtains <item2>.
    ITEM_EFFECT_DISAPPEARS          = 378, -- <actor> uses a <item>.<br><target>'s <status> effect disappears!
    ITEM_PETRA_VANISH               = 399, -- <actor> uses a <item>.<br>All of <target>'s Petras vanish!
    ITEM_AILMENTS_DISAPPEARS        = 400, -- <actor> uses a <item>.<br><num> of <target>'s effects disappears!
    ITEM_EFFECTS_DISAPPEARS         = 401, -- <actor> uses a <item>.<br><num> of <target>'s status ailments disappears!
    ITEM_NO_EFFECT                  = 408, -- <actor> uses a <item>.<br>No effect on <target>.
    ITEM_NO_TARGET                  = 410, -- No target available. Unable to use item.
    ITEM_UNABLE_TO_USE_PARTY_LEADER = 580, -- Unable to use <item>. The party leader is in either an area beyond warping range or a place you have yet to visit.
    ITEM_NO_ITEMS_EQUIPPED          = 514, -- You do not have the proper items equipped to use the <item>.
    ITEM_NO_USE_SNEAK               = 518, -- The <item> cannot be used while under the effect of invisible or sneak

    -- Two-handed Weapon Grips
    GRIP_NO_2HAND_EQUIPPED          = 512, -- You must have a two-handed weapon equipped in the main weapon slot in order to equip a grip
    GRIP_NOT_COMPATIBLE             = 513, -- This grip is not compatible with the two-handed weapon you currently have equipped

    -- Ranged
    NO_RANGED_WEAPON                = 216, -- You do not have an appropriate ranged weapon equipped.
    CANNOT_SEE                      = 217, -- You cannot see <target>.
    MOVE_AND_INTERRUPT              = 218, -- You move and interrupt your aim.

    -- Additional effects and spike effects
    SPIKES_EFFECT_DMG               = 44,  -- <Defender>'s spikes deal <number> points of damage to the <Attacker>.
    SPIKES_EFFECT_HP_DRAIN          = 132, -- <Defender>'s spikes drain <number> HP from the <Attacker>.
    ADD_EFFECT_MP_HEAL              = 152, -- Additional effect: The <player> recovers <number> MP.
    ADD_EFFECT_STATUS               = 160, -- Additional effect: <Status Effect>.
    ADD_EFFECT_HP_DRAIN             = 161, -- Additional effect: <number> HP drained from <target>.
    ADD_EFFECT_MP_DRAIN             = 162, -- Additional effect: <number> MP drained from <target>.
    ADD_EFFECT_DMG                  = 163, -- Additional effect: <number> points of damage.
    ADD_EFFECT_DMG_2                = 229, -- Additional effect: The <target> takes <number> additional points of damage.
    ADD_EFFECT_STATUS_2             = 164, -- Additional effect: <Status Effect>. (Duplicate?)
    ADD_EFFECT_TP_DRAIN             = 165, -- Additional effect: <number> TP drained from <target>.
    ADD_EFFECT_SELFBUFF             = 166, -- Additional effect: <player> gains the effect of <Status Effect>.
    ADD_EFFECT_HP_HEAL              = 167, -- Additional effect: The <player> recovers <number> HP.
    ADD_EFFECT_DISPEL               = 168, -- Additional effect: <target>'s <Status Effect> effect disappears!
    ADD_EFFECT_WARP                 = 169, -- Additional effect: Warp! (used by Halloween staves)
    SPIKES_EFFECT_RECOVER           = 373, -- <defender> recovers <number> hit points!
    STATUS_SPIKES                   = 374, -- Striking <defender>'s armor causes <attacker> to become <status effect>.
    SPIKES_EFFECT_HEAL              = 383, -- <defenders>'s spikes restore <number> HP to the <attacker>.  (element absorbed)
    ADD_EFFECT_HEAL                 = 384, -- Additional effect: <target> recovers <number> HP.

    -- Status
    RECOVERS_HP                     = 24,  -- <target> recovers <number> HP.
    RECOVERS_MP                     = 25,  -- <target> recovers <number> MP.
    RECOVERS_HP_AND_MP              = 26,  -- <target> recovers <number> HP and MP.
    IS_PARALYZED_2                  = 84,  -- <target> is paralyzed.
    DOOM_COUNTER                    = 112, -- <target's> doom counter is now down to <param>.
    IS_STATUS                       = 203, -- <target> is <status>.
    IS_NO_LONGER_STATUS             = 204, -- <target> is no longer <status>.
    GAINS_EFFECT_OF_STATUS          = 205, -- <target> gains the effect of <status>.
    STATUS_WEARS_OFF                = 206, -- <target>'s <status> effect wears off.
    ABOUT_TO_WEAR_OFF               = 251, -- The effect of <status> is about to wear off.
    ALL_ABILITIES_RECHARGED         = 361, -- All of <target>'s abilities are recharged.
    PETRIFICATION_COUNTER           = 530, -- <target's> petrification counter is now down to <param>.

    -- Battlefield
    UNABLE_TO_ACCESS_SJ             = 107, -- <player> is temporarily unable to access support job abilities
    TIME_LEFT                       = 202, -- Time left: (0:00:00)
    SKILLCHAIN_COSMIC_ELUCIDATION   = 302, -- Skillchain: Cosmic Elucidation. <target> takes <number> points of damage.

    -- Dynamis
    TIME_DYNAMIS_EXTENDED           = 448, -- Time allowed in Dynamis has been extended by <param> minutes
    TIME_DYNAMIS_REMAINING          = 449, -- ----== WARNING ==----Time remaining in Dynamis: <param> minutes.

    -- Charm
    CHARM_SUCCESS                   = 136, -- <actor> uses charm. <target> is now under the <actor>'s control.
    CHARM_FAIL                      = 137, -- <actor> uses charm. <actor> fails to charm <target>.
    CANNOT_CHARM                    = 210, -- <actor> cannot charm <target>!
    VERY_DIFFICULT_CHARM            = 211, -- It would be very difficult for <actor> to charm <target>.
    DIFFICULT_TO_CHARM              = 212, -- It would be difficult for <actor> to charm <target>.
    MIGHT_BE_ABLE_CHARM             = 213, -- <actor> might be able to charm <target>.
    SHOULD_BE_ABLE_CHARM            = 214, -- <actor> should be able to charm <target>.

    -- Soultrapper (Pankration)
    SOULTRAPPER_SUCCESS             = 515, -- <actor> has successfully recorded the target's image onto an <item>.
    SOULTRAPPER_FAILED              = 516, -- <actor> was unable to capture the target's image.

    -- BLU
    LEARNS_SPELL                    = 419, -- <target> learns (NULL)!

    -- COR
    ROLL_MAIN                       = 420, -- The <player> uses .. The total comes to ..! <target> receives the effect of ..
    ROLL_SUB                        = 421, -- <target> receives the effect of ..
    ROLL_MAIN_FAIL                  = 422, -- The <player> uses .. The total comes to ..! No effect on <target>.
    ROLL_SUB_FAIL                   = 423, -- No effect on <target>.
    DOUBLEUP                        = 424, -- The <player> uses Double-Up. The total for . increases to ..! <target> receives the effect of ..
    DOUBLEUP_FAIL                   = 425, -- The <player> uses Double-Up. The total for . increases to ..! No effect on <target>.
    DOUBLEUP_BUST                   = 426, -- The <player> uses Double-Up. Bust! <target> loses the effect of ..
    DOUBLEUP_BUST_SUB               = 427, -- <target> loses the effect of ..
    NO_ELIGIBLE_ROLL                = 428, -- There are no rolls eligible for Double-Up. Unable to use ability.
    ROLL_ALREADY_ACTIVE             = 429, -- The same roll is already active on the <player>.

    EFFECT_ALREADY_ACTIVE           = 523, -- The same effect is already active on <player>.

    -- PLD
    COVER_SUCCESS                   = 311, -- The <player> covers <target>.
    COVER_FAILURE                   = 312, -- The <player>'s attempt to cover has no effect.

    -- PUP
    AUTO_EXCEEDS_CAPACITY           = 745, -- Your automaton exceeds one or more elemental capacity values and cannot be activated.
    AUTO_OVERLOAD_CHANCE            = 798, -- The <pet>'s overload chance is <number>%.
    AUTO_OVERLOADED                 = 799, -- The <pet>'s overload chance is <number>%. The <pet> is overloaded!
    PROVOKE_SWITCH                  = 418, -- The <actor> uses <action> on <target>. The <target> switches to <actor>!

    -- DNC
    NO_FINISHINGMOVES               = 524, -- You have not earned enough finishing moves to perform that action.
    SPECTRAL_JIG                    = 532, -- <user> uses <ability>. <target> receives the effect of Sneak and Invisible.

    -- GEO
    SAME_EFFECT_LUOPAN              = 660, -- The same effect is already active on that luopan!.
    LUOPAN_ALREADY_PLACED           = 661, -- <player> has already placed a luopan. Unable to use ability.
    REQUIRE_LUOPAN                  = 662, -- This action requires a luopan.
    LUOPAN_HP_RATE_DOWN             = 663, -- <player> uses <ability>. The luopan's HP consumption rate has been reduced.
    LUOPAN_HP_RATE_UP               = 664, -- <player> uses <ability>. The luopan's HP consumption rate has been increased.
    HAS_LUOPON_NO_USE               = 665, -- <player> has a pet. Unable to use ability.

    --- RUN
    REQUIRE_RUNE                    = 666, -- That action requires the ability Rune Enchantment.
    SWORDPLAY_GAIN                  = 667, -- <Player> uses <Ability>. Accuracy and evasion are enhanced.
    VALLATION_GAIN                  = 668, -- <Target> receives the effect of Vallation, reducing damage taken from certain elemental magic spells. -- Vallation and Valiance both use this message for the RUN using the ja
    VALIANCE_GAIN_PARTY             = 669, -- Magic damage of a certain element is reduced for <Target>                                             -- This message is when a party member recieves the aoe effect of Valiance
    LIEMENT_GAIN                    = 670, -- <Player> uses <Ability>. <Target> can now absorb magic damage of a certain element.
    PFLUG_GAIN                      = 671, -- <Player> uses <Ability>. <Target> now has enhanced resistance.
    GAMBIT_GAIN                     = 672, -- <Player> uses <Ability>. <Target> receives the effect of Gambit, reducing magic defense against magic of a certain element.

    -- Fields / Grounds of Valor
    FOV_DEFEATED_TARGET             = 558, -- You defeated a designated target.<br>(Progress: <number>/<number2>)
    FOV_COMPLETED_REGIME            = 559, -- You have successfully completed the training regime.
    FOV_OBTAINS_GIL                 = 565, -- <target> obtains <gil>.
    FOV_OBTAINS_TABS                = 566, -- <target> obtains <number> tab.<br>(Total: <number>)
    FOV_REGIME_BEGINS_ANEW          = 643, -- Your current training regime will begin anew!

    -- Magian Trials
    MAGIAN_TRIAL_COMPLETE           = 584, -- You have completed Trial <trialID>. Report your success to a Magian Moogle.

    -- Depoil Statuses
    DESPOIL_ATT_DOWN                = 593, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Attack Down.
    DESPOIL_DEF_DOWN                = 594, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Defense Down.
    DESPOIL_MATT_DOWN               = 595, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Magic Atk. Down.
    DESPOIL_MDEF_DOWN               = 596, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Magic Def. Down.
    DESPOIL_EVA_DOWN                = 597, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Evasion Down.
    DESPOIL_ACC_DOWN                = 598, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Accuracy Down.
    DESPOIL_SLOW                    = 599, -- <actor> uses <ability>.<br><actor> steals a <item> from <target>.<br>Additional effect: <target> is afflicted with Slow.

    -- Records of Eminence
    ROE_COMPLETE                    = 690, -- You have completed the following Records of Eminence objective: <record>.
    ROE_REPEAT_OR_CANCEL            = 691, -- This objective may be repeated, and can be cancelled from the menu.
    ROE_RECEIVE_SPARKS              = 692, -- You receive <amount> sparks of eminence, and now possess a total of <amount>.
    ROE_BONUS_ITEM                  = 693, -- As a special bonus for your valiant efforts, you have been awarded <item>!
    ROE_BONUS_SPARKS                = 694, -- As a special bonus for your valiant efforts, you have been awarded <amount> sparks of eminence!
    ROE_UNABLE_BONUS_ITEM           = 695, -- Unable to receive special bonus. Make room in your inventory and receive your reward from the Records of Eminence menu.
    ROE_YET_TO_RECEIVE              = 696, -- You have yet to receive certain special bonuses from the objectives you have completed. Make room in your inventory and receive your reward from the Records of Eminence menu.
    ROE_RECORD                      = 697, -- Records of Eminence: <record>.
    ROE_PROGRESS                    = 698, -- Progress: <amount>/<amount>.
    ROE_NEW_OBJECTIVE               = 699, -- A new objective has been added!
    ROE_OBTAINED_KEY_ITEM           = 706, -- You have obtained <key item> as a special reward!
    ROE_FIRST_TIME_SPARKS           = 707, -- As a first-time bonus, you receive <amount> sparks of eminence for a total of <amount>!
    ROE_BONUS_ITEM_PLURAL           = 709, -- As a special bonus for your valiant efforts, you have been awarded the following: <itemid> x<amount>!
    ROE_TIMED_CLEAR                 = 710, -- You are cleared to fulfill this objective once again.
    ROE_RECEIVED_ACCOLADES          = 741, -- You have gained <amount> Unity accolade[/s] for a total of <amount>!

    -- TRUST & ALTER EGO
    TRUST_NO_CAST_TRUST             = 700, -- You are unable to use Trust magic at this time.
    TRUST_NO_CALL_AE                = 717, -- You cannot call forth alter egos here.

    -- Monstrosity
    FERETORY_COUNTDOWN              = 679, -- <actor> will return to the Feretory in <n>
}

-- Used to modify certain basic messages.
---@enum xi.actionModifier
xi.msg.actionModifier =
{
    NONE        = 0x00,
    COVER       = 0x01,
    RESIST      = 0x02, -- Resist! <Regular message> -- Used for resist traits triggers.
    MAGIC_BURST = 0x04, -- Currently known to be used for Swipe/Lunge only
    IMMUNOBREAK = 0x08,
}

-----------------------------------
-- System Messages
-----------------------------------

---@enum xi.system
xi.msg.system =
{
    GLOBAL_TRUST_OFFSET          = 0,
    EXECUTING_LOGOUT             = 7,   -- Executing logout in <seconds> seconds. Cancel healing to remain logged in.
    EXECUTING_SHUTDOWN           = 35,  -- Executing shutdown in <seconds> seconds. Cancel healing to remain logged in.
    TRUST_NO_SEEKING_PARTY       = 296, -- You cannot use Trust magic while seeking a party.
    TRUST_DELAY_NEW_PARTY_MEMBER = 297, -- While inviting a party member, you must wait a while before using Trust magic.
    TRUST_MAXIMUM_NUMBER         = 298, -- You have called forth your maximum number of alter egos.
    TRUST_ALREADY_CALLED         = 299, -- That alter ego has already been called forth.
    TRUST_NO_ENMITY              = 300, -- You cannot use Trust magic while having gained enmity.
    TRUST_SOLO_OR_LEADER         = 301, -- You cannot use Trust magic unless you are solo or the party leader.
}

-----------------------------------
-- Combat/Action Messages (used with CMessageCombatPacket/:messageCombat())
-----------------------------------

---@enum xi.combat
xi.msg.combat =
{
    USE_OBTAIN_ESCHA_SILT = 765, -- <name> uses <item>. <name> obtains <n> escha silt.
    USE_OBTAIN_ESCHA_BEAD = 766, -- <name> uses <item>. <name> obtains <n> escha beads.
}
