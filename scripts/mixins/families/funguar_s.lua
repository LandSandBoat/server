--[[
https://www.bg-wiki.com/ffxi/Category:Funguar

The Funguar in the past have a unique mechanic with stealing:
- stolen item is based on animation sub
- stealing an item removes a bulb just like the respective mobskill
--]]
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Maps animation sub to steal item
local stealItems =
{
    [0] = xi.item.WOOZYSHROOM,
    [1] = xi.item.DANCESHROOM,
    [2] = xi.item.AGARICUS_MUSHROOM,
}

local updateStealItem = function(mob)
    local animSub = mob:getMobMod(xi.mobMod.VAR)

    if stealItems[animSub] then
        mob:setStealItem(stealItems[animSub])
    else
        mob:itemStolen()
    end
end

local updateRegen = function(mob)
    if
        mob:getWeather() == xi.weather.RAIN or
        mob:getWeather() == xi.weather.SQUALL
    then
        mob:setMod(xi.mod.REGEN, 10)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

g_mixins.families.funguar_s = function(funguarMob)
    funguarMob:addListener('SPAWN', 'FUNGUAR_SPAWN', function(mob)
        updateStealItem(mob)
    end)

    funguarMob:addListener('ROAM_TICK', 'FUNGUAR_RTICK', function(mob)
        updateRegen(mob)
    end)

    funguarMob:addListener('COMBAT_TICK', 'FUNGUAR_CTICK', function(mob)
        updateRegen(mob)
    end)

    funguarMob:addListener('WEAPONSKILL_USE', 'FUNGUAR_WS_USE', function(mob, target, skillID)
        updateStealItem(mob)
    end)

    funguarMob:addListener('ITEM_STOLEN', 'FUNGUAR_ITEM_STOLEN', function(mob)
        local newAnimSub = mob:getAnimationSub() + 1
        if newAnimSub <= 3 then
            mob:setMobMod(xi.mobMod.VAR, newAnimSub)
            mob:setAnimationSub(newAnimSub)
            updateStealItem(mob)
        end
    end)
end

return g_mixins.families.funguar_s
