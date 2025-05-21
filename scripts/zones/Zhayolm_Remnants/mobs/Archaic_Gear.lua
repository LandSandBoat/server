-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Archaic Gear
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
mixins = { require('scripts/mixins/families/gear') }
-----------------------------------

local path =
{
    [5] =
    {
        [2] =
        {
            -- 1st room
            [1] =
            {
                { x = -349, y = 0, z = -229, wait = 10000 },
                { x = -340, y = 0, z = -229, wait = 10000 },
            },
            [2] =
            {
                { x = -340, y = 0, z = -229, wait = 10000 },
                { x = -331, y = 0, z = -229, wait = 10000 },
            },
            [3] =
            {
                { x = -331, y = 0, z = -229, wait = 10000 },
                { x = -331, y = 0, z = -220, wait = 10000 },
            },
            [4] =
            {
                { x = -331, y = 0, z = -220, wait = 10000 },
                { x = -331, y = 0, z = -211, wait = 10000 },
            },
            [5] =
            {
                { x = -331, y = 0, z = -211, wait = 10000 },
                { x = -340, y = 0, z = -211, wait = 10000 },
            },
            [6] =
            {
                { x = -340, y = 0, z = -211, wait = 10000 },
                { x = -349, y = 0, z = -211, wait = 10000 },
            },
            [7] =
            {
                { x = -349, y = 0, z = -211, wait = 10000 },
                { x = -349, y = 0, z = -220, wait = 10000 },
            },
            [8] =
            {
                { x = -349, y = 0, z = -220, wait = 10000 },
                { x = -349, y = 0, z = -229, wait = 10000 },
            },
            -- large room
            [9] =
            {
                { x = -260, y = 0, z = -126.5 },
                { x = -260, y = 0, z = -103.5 },
            },
            [10] =
            {
                { x = -260, y = 0, z = -73.5 },
                { x = -260, y = 0, z = -95.5 },
            },
            [11] =
            {
                { x = -233.5, y = 0, z = -100 },
                { x = -256, y = 0, z = -100 },
            },
            [12] =
            {
                { x = -286.5, y = 0, z = -100 },
                { x = -264, y = 0, z = -100 },
            },
            [13] =
            {
                { x = -286.5, y = 0, z = -126.5 },
                { x = -233.5, y = 0, z = -126.5 },
            },
            [14] =
            {
                { x = -233.5, y = 0, z = -126.5 },
                { x = -233.5, y = 0, z = -73.5 },
            },
            [15] =
            {
                { x = -233.5, y = 0, z = -73.5 },
                { x = -286.5, y = 0, z = -73.5 },
            },
            [16] =
            {
                { x = -286.5, y = 0, z = -73.5 },
                { x = -286.5, y = 0, z = -126.5 },
            },
            -- 2nd small room
            [17] =
            {
                { x = -300, y = 0, z = -189, wait = 10000 },
                { x = -309, y = 0, z = -180, wait = 10000 },
            },
            [18] =
            {
                { x = -309, y = 0, z = -180, wait = 10000 },
                { x = -300, y = 0, z = -171, wait = 10000 },
            },
            [19] =
            {
                { x = -300, y = 0, z = -171, wait = 10000 },
                { x = -291, y = 0, z = -180, wait = 10000 },
            },
            [20] =
            {
                { x = -291, y = 0, z = -180, wait = 10000 },
                { x = -300, y = 0, z = -189, wait = 10000 },
            },
        },
    },
}

local getPath = function(mob)
    local instance  = mob:getInstance()
    local stage     = instance:getStage()
    local progress  = instance:getProgress()
    local mobID     = mob:getID()
    local pathNodes = 0
    local order     = 0

    for k = #ID.mob.ARCHAIC_GEAR, 1, -1 do
        if mobID == ID.mob.ARCHAIC_GEAR[k] then
            order = k
            break
        end
    end

    pathNodes = path[stage][progress][order]

    return pathNodes
end

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if instance then
        local stage    = instance:getStage()
        local progress = instance:getProgress()
        local mobID    = mob:getID()

        if stage == 5 and progress == 2 then
            if
                utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 1, 8)) or
                utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 17, 20))
            then
                mob:delImmunity(xi.immunity.DARK_SLEEP)
                mob:pathThrough(getPath(mob), xi.path.flag.PATROL)
            elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 9, 16)) then
                mob:pathThrough(getPath(mob), xi.path.flag.PATROL)
                mob:addImmunity(xi.immunity.LIGHT_SLEEP)
            end
        elseif stage == 6 then
            mob:addImmunity(xi.immunity.LIGHT_SLEEP)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            if instance:getStage() == 6 then
                instance:setLocalVar('6th Door', instance:getLocalVar('6th Door') + 1)
            end
        end
    end
end

return entity
