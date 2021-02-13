-----------------------------------
-- ID: 19006
-- Item: Tizona
-- Additional effect: MP Gain from damage dealt
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

local chance =
{
    [19006] = 10, -- 75
    [19075] = 15, -- 80
    [19095] = 20, -- 85
    [19627] = 25, -- 90
    [19725] = 25, -- 95
    [19834] = 30, -- 99
    [19963] = 30, -- 99 AG
    [20651] = 30, -- 119
    [20652] = 30, -- 119 AG
    [20688] = 30  -- 119 III
}

item_object.onAdditionalEffect = function(player, target, damage)
    if math.random(100) <= chance[player:getEquipID(tpz.slot.MAIN)] then
        local drain = math.floor(damage * math.random(10, 20) / 100)
        player:addMP(drain)

        return tpz.subEffect.MP_DRAIN, tpz.msg.basic.ADD_EFFECT_MP_DRAIN, drain
    end

    return 0, 0, 0
end

return item_object
