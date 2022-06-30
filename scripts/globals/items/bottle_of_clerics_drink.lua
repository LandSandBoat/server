-----------------------------------
-- ID: 5395
-- Item: bottle_of_clerics_drink
-- Item Effect: Instantly removes all negative status effects from nearby party members
--              Does not remove Plague or Curse
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
        xi.effect.PETRIFICATION,
        xi.effect.DISEASE,
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

    local count = 32

    target:forMembersInRange(10, function(member)
        xi.item_utils.removeMultipleEffects(member, effects, count)
    end)
end

return item_object
