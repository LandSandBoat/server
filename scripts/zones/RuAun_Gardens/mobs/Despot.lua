-----------------------------------
-- Area: RuAun Gardens
--   NM: Despot
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DESPOT - 16] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 15] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 14] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 13] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 12] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 11] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 10] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 9 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 8 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 7 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 6 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 5 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 4 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 3 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 2 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 1 ] = ID.mob.DESPOT,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 29250)
    mob:setMobMod(xi.mobMod.MUG_GIL, 3250)
end

entity.onMobSpawn = function(mob)
    local ph = GetMobByID(mob:getLocalVar('ph'))
    if ph then
        local pos = ph:getPos()
        mob:setPos(pos.x, pos.y, pos.z, pos.r)
        local killerId = ph:getLocalVar('killer')
        if killerId ~= 0 then
            local killer = GetPlayerByID(killerId)
            if
                killer and
                not killer:isEngaged() and
                killer:checkDistance(mob) <= 50
            then
                mob:updateClaim(killer)
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 536 then
        local panzerfaustCounter = mob:getLocalVar('panzerfaustCounter')
        local panzerfaustMax = mob:getLocalVar('panzerfaustMax')

        if panzerfaustCounter == 0 and panzerfaustMax == 0 then
            panzerfaustMax = math.random(2, 5)
            mob:setLocalVar('panzerfaustMax', panzerfaustMax)
        end

        panzerfaustCounter = panzerfaustCounter + 1
        mob:setLocalVar('panzerfaustCounter', panzerfaustCounter)

        if panzerfaustCounter > panzerfaustMax then
            mob:setLocalVar('panzerfaustCounter', 0)
            mob:setLocalVar('panzerfaustMax', 0)
        else
            mob:useMobAbility(536)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('PH_VAR')
end

return entity
