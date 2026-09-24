-----------------------------------
-- Removes disengage behavior added when LB2 ??? were added.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('phoenix_boreal_draw_in')

local tunnelBoundaries =
{
    Boreal_Coeurl = function(target)
        return target:getZPos() < 260
    end,

    Boreal_Hound = function(target)
        return target:getXPos() > -11 and target:getZPos() > -465
    end,

    Boreal_Tiger = function(target)
        return target:getZPos() < 335
    end,
}

for mobName, isOutsideTunnel in pairs(tunnelBoundaries) do
    m:addOverride(string.format('xi.zones.Xarcabard.mobs.%s.onPathPoint', mobName), function(mob)
        if not mob:isEngaged() then
            super(mob)
        end
    end)

    m:addOverride(string.format('xi.zones.Xarcabard.mobs.%s.onMobFight', mobName), function(mob, target)
        local outsideTunnel = isOutsideTunnel(target)

        mob:setMobMod(xi.mobMod.NO_MOVE, outsideTunnel and 1 or 0)
        utils.drawIn(target,
        {
            conditions = { outsideTunnel },
            position   = mob:getPos(),
            offset     = 5,
            degrees    = 180,
            wait       = 2,
        })
    end)
end
