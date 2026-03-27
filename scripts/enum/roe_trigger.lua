xi = xi or {}

---@enum xi.roeTrigger
xi.roeTrigger =
{
    DEFEAT_MOB           = 1,  -- Player kills a Mob (Counts for mobs killed by partymembers)
    USE_WEAPONSKILL      = 2,  -- Player Weapon skill used
    LOOT_ITEM            = 3,  -- Player successfully loots an item
    SUCCESSFUL_SYNTHESIS = 4,  -- Player synth success
    TAKE_DAMAGE          = 5,  -- Player takes Damage
    DEAL_DAMAGE          = 6,  -- Player deals Damage
    GAIN_EXPERIENCE      = 7,  -- Player gains EXP
    HEAL_ALLY            = 8,  -- Player heals self/ally with spell
    BUFF_ALLY            = 9,  -- Player buffs ally
    ACHIEVE_LEVEL        = 10, -- Player levelup
    COMPLETE_QUEST       = 11, -- Player completes quest
    COMPLETE_MISSION     = 12, -- Player completes mission
    HELM_SUCCESS         = 13, -- Player has a successful harvesting event
    CHOCOBO_DIG_SUCCESS  = 14, -- Player successfully chocobo digs
    UNITY_CHAT           = 15, -- Player uses Unity Chat
    MAGIC_BURST          = 16, -- Player performs a Magic Burst
    HEAL_UNITY_ALLY      = 17, -- Player heals someone in their party/alliance with the same Unity
    TRIGGER_NPC          = 18, -- Player talk to RoE - TODO: Make this generic and utilize for other NPCs
    SPELL_CAST_ON_MOB    = 19, -- Player casts a spell on a mob (cure on undead, bind, etc.)
    ITEM_USE             = 20, -- Player uses a consumable item (food, medicine)
    FISH_CATCH           = 21, -- Player catches a fish/item while fishing
    SKILLCHAIN           = 22, -- Player closes a skillchain on a mob
}
