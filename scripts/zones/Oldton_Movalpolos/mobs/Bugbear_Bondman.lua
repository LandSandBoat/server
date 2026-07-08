-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Bugbear Bondman
-- Note: PH for Bugbear Strongman
-----------------------------------
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- These act as guards and do not roam normally.
    local mobId = mob:getID()
    if
        mobId == ID.mob.BUGBEAR_BONDMAN[1] or
        mobId == ID.mob.BUGBEAR_BONDMAN[2] or
        mobId == ID.mob.BUGBEAR_BONDMAN[8] or
        mobId == ID.mob.BUGBEAR_BONDMAN[9] or
        mobId == ID.mob.BUGBEAR_BONDMAN[10] or
        mobId == ID.mob.BUGBEAR_BONDMAN[11]
    then
        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
        mob:setMobMod(xi.mobMod.ROAM_RESET_FACING, 1)
        mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    end
end

entity.onMobRoam = function(mob)
    local mobId    = mob:getID()
    local spawnPos = mob:getSpawnPos()
    local pos      = mob:getPos()

    -- These act as guards and do not roam normally.
    if
        mobId == ID.mob.BUGBEAR_BONDMAN[1] or
        mobId == ID.mob.BUGBEAR_BONDMAN[2] or
        mobId == ID.mob.BUGBEAR_BONDMAN[8] or
        mobId == ID.mob.BUGBEAR_BONDMAN[9] or
        mobId == ID.mob.BUGBEAR_BONDMAN[10] or
        mobId == ID.mob.BUGBEAR_BONDMAN[11]
    then
        -- If not at spawn position, path back to it
        if spawnPos.x ~= pos.x or spawnPos.z ~= pos.z then
            mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
        end
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BUGBEAR_STRONGMAN[1], 10, 1) -- no cooldown
end

return entity
