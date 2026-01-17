---------------------------------------------
--  Doomvoid
--  Description:
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------

local doomvoidDestinations =
{
    { var = 'KingArthroFight',  value = 1, mobID = 17129519, pos = { x =  306.000, y = -9.000, z = -288.000, rot = 167, zone = xi.zone.EVERBLOOM_HOLLOW } },
    { var = 'LambtonWormFight', value = 1, mobID = 17129532, pos = { x =  -19.938, y = -8.750, z = -320.105, rot =  65, zone = xi.zone.EVERBLOOM_HOLLOW } },
    { var = 'SerketFight',      value = 1, mobID = 17305666, pos = { x =  102.365, y = -0.206, z = -295.594, rot =  60, zone = xi.zone.GHOYUS_REVERIE } },
    { var = 'LambtonWormFight', value = 2, mobID = 17305667, pos = { x = -459.000, y =  0.000, z =  -48.000, rot =  50, zone = xi.zone.GHOYUS_REVERIE } },
    { var = 'GuivreFight',      value = 1, mobID = 17158202, pos = { x =  -20.541, y =  0.000, z =  249.768, rot =  60, zone = xi.zone.RUHOTZ_SILVERMINES } },
    { var = 'LambtonWormFight', value = 3, mobID = 17158203, pos = { x =  347.866, y =  0.000, z = -460.499, rot = 100, zone = xi.zone.RUHOTZ_SILVERMINES } },
}

local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob)

    if mob:getHPP() <= 25 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    for _, destination in ipairs(doomvoidDestinations) do
        if mob:getLocalVar(destination.var) == destination.value then
            SpawnMob(destination.mobID)
            target:setPos(destination.pos.x, destination.pos.y, destination.pos.z, destination.pos.rot, destination.pos.zone)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
    DespawnMob(mob:getID())
end

return mobskillObject
