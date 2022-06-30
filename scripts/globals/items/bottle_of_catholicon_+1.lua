-----------------------------------
-- ID: 4208
-- Item: bottle_of_catholicon_+1
-- Item Effect: Instantly removes up to 6 negative status effects from target
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effects =
    {
        xi.effect.PARALYSIS,
        xi.effect.POISON,
        xi.effect.BLINDNESS,
        xi.effect.SILENCE,
        xi.effect.DISEASE,
        xi.effect.PETRIFICATION,
        xi.effect.BIND,
        xi.effect.WEIGHT,
        xi.effect.ADDLE,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.DIA,
        xi.effect.BIO,
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
        xi.effect.MAX_HP_DOWN,
        xi.effect.MAX_MP_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,
        xi.effect.MAGIC_DEF_DOWN,
        xi.effect.INHIBIT_TP,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN
    }

    local count = 6

    xi.item_utils.removeMultipleEffects(target, effects, count)
end

return item_object
