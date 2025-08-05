-----------------------------------
-- Effect Source Types
-----------------------------------
xi = xi or {}

---@enum xi.effectSourceType
xi.effectSourceType =
{
    NONE           = 0,  -- Default or None.
    ITEM           = 1,  -- Effect came from an item.
    EQUIPPED_ITEM  = 2,  -- Effect came from an enchantment or similar effect from equipped items.
    TEMPORARY_ITEM = 3,  -- Effect came from a temporary item.
    MOB_SCRIPT     = 4,  -- Effect came from a mob's script(Mechanics, Aura, etc)
    MOB_ATTACK     = 5,  -- Effect came from an additional effect attached to a mob's attack.
    MOB_SKILL      = 6,  -- Effect came from a mob skill.
    FOOD           = 7,  -- Effect came from a food item.
    MAGIC_WHITE    = 8,  -- Effect came from a white magic spell.
    MAGIC_BLACK    = 9,  -- Effect came from a black magic spell.
    MAGIC_BLUE     = 10, -- Effect came from a blue magic spell.
    MAGIC_SONG     = 11, -- Effect came from a song.
    ABILITY        = 12, -- Effect came from an ability.
    WEAPONSKILL    = 13, -- Effect came from a weaponskill.
    ENVIRONMENT    = 14, -- Effect came from an enviromental source such as a trap or hazard.
}
