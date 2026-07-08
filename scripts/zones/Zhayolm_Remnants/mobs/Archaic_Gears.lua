-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Archaic Gears
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
mixins = { require('scripts/mixins/families/gear') }
-----------------------------------

local path =
{
    [5] =
    {
        [1] =
        {
            -- 1st small
            [1] =
            {
                { x = -331, y = 0, z = 20, wait = 10000 },
                { x = -331, y = 0, z = 29, wait = 10000 },
            },
            [2] =
            {
                { x = -331, y = 0, z = 29, wait = 10000 },
                { x = -340, y = 0, z = 29, wait = 10000 },
            },
            [3] =
            {
                { x = -340, y = 0, z = 29, wait = 10000 },
                { x = -349, y = 0, z = 29, wait = 10000 },
            },
            [4] =
            {
                { x = -349, y = 0, z = 29, wait = 10000 },
                { x = -349, y = 0, z = 20, wait = 10000 },
            },
            [5] =
            {
                { x = -349, y = 0, z = 20, wait = 10000 },
                { x = -349, y = 0, z = 11, wait = 10000 },
            },
            [6] =
            {
                { x = -349, y = 0, z = 11, wait = 10000 },
                { x = -340, y = 0, z = 11, wait = 10000 },
            },
            [7] =
            {
                { x = -340, y = 0, z = 11, wait = 10000 },
                { x = -331, y = 0, z = 11, wait = 10000 },
            },
            [8] =
            {
                { x = -331, y = 0, z = 11, wait = 10000 },
                { x = -331, y = 0, z = 20, wait = 10000 },
            },
            -- large room
            [13] =
            {
                { x = -420, y = 0, z = -73.5 },
                { x = -420, y = 0, z = -96 },
            },
            [14] =
            {
                { x = -420, y = 0, z = -126.5 },
                { x = -420, y = 0, z = -104 },
            },
            [15] =
            {
                { x = -393.5, y = 0, z = -100 },
                { x = -416, y = 0, z = -100 },
            },
            [16] =
            {
                { x = -446.5, y = 0, z = -100 },
                { x = -424, y = 0, z = -100 },
            },
            [17] =
            {
                { x = -446.5, y = 0, z = -73.5 },
                { x = -393.5, y = 0, z = -73.5 },
            },
            [18] =
            {
                { x = -393.5, y = 0, z = -73.5 },
                { x = -446.5, y = 0, z = -73.5 },
            },
            [19] =
            {
                { x = -393.5, y = 0, z = -73.5 },
                { x = -393.5, y = 0, z = -126.5 },
            },
            [20] =
            {
                { x = -393.5, y = 0, z = -126.5 },
                { x = -393.5, y = 0, z = -73.5 },
            },
            [21] =
            {
                { x = -393.5, y = 0, z = -126.5 },
                { x = -446.5, y = 0, z = -126.5 },
            },
            [22] =
            {
                { x = -446.5, y = 0, z = -126.5 },
                { x = -393.5, y = 0, z = -126.5 },
            } ,
            [23] =
            {
                { x = -446.5, y = 0, z = -126.5 },
                { x = -446.5, y = 0, z = -73.5 },
            },
            [24] =
            {
                { x = -446.5, y = 0, z = -73.5 },
                { x = -446.5, y = 0, z = -126.5 },
            },
            -- 2nd small room
            [25] =
            {
                { x = -375.5, y = 0, z = -19, wait = 10000 },
                { x = -375.5, y = 0, z = -10, wait = 10000 },
            },
            [26] =
            {
                { x = -375.5, y = 0, z = -21, wait = 10000 },
                { x = -375.5, y = 0, z = -30, wait = 10000 },
            },
            [27] =
            {
                { x = -384.5, y = 0, z = -21, wait = 10000 },
                { x = -384.5, y = 0, z = -30, wait = 10000 },
            },
            [28] =
            {
                { x = -384.5, y = 0, z = -19, wait = 10000 },
                { x = -384.5, y = 0, z = -10, wait = 10000 },
            },
            [29] =
            {
                { x = -390, y = 0, z = -24.5, wait = 10000 },
                { x = -381, y = 0, z = -24.5, wait = 10000 },
            },
            [30] =
            {
                { x = -390, y = 0, z = -15.5, wait = 10000 },
                { x = -381, y = 0, z = -15.5, wait = 10000 },
            },
            [31] =
            {
                { x = -370, y = 0, z = -24.5, wait = 10000 },
                { x = -379, y = 0, z = -24.5, wait = 10000 },
            },
            [32] =
            {
                { x = -370, y = 0, z = -15.5, wait = 10000 },
                { x = -379, y = 0, z = -15.5, wait = 10000 },
            },
        },
    },
    [6] =
    {
        [1] =
        {
            [33] =
            {
                { x = -338, y = 0, z = 278, wait = 5000 },
                { x = -360, y = 0, z = 278, wait = 5000 },
            },
            [34] =
            {
                { x = -338, y = 0, z = 262, wait = 5000 },
                { x = -360, y = 0, z = 262, wait = 5000 },
            },
            [35] =
            {
                { x = -338, y = 0, z = 242, wait = 5000 },
                { x = -360, y = 0, z = 242, wait = 5000 },
            },
            [36] =
            {
                { x = -338, y = 0, z = 222, wait = 5000 },
                { x = -360, y = 0, z = 222, wait = 5000 },
            },
            [37] =
            {
                { x = -338, y = 0, z = 202, wait = 5000 },
                { x = -360, y = 0, z = 202, wait = 5000 },
            },
            [38] =
            {
                { x = -342, y = 0, z = 276, wait = 5000 },
                { x = -320, y = 0, z = 276, wait = 5000 },
            },
            [39] =
            {
                { x = -342, y = 0, z = 257, wait = 5000 },
                { x = -320, y = 0, z = 257, wait = 5000 },
            },
            [40] =
            {
                { x = -342, y = 0, z = 238, wait = 5000 },
                { x = -320, y = 0, z = 238, wait = 5000 },
            },
            [41] =
            {
                { x = -342, y = 0, z = 218, wait = 5000 },
                { x = -320, y = 0, z = 218, wait = 5000 },
            },
            [42] =
            {
                { x = -342, y = 0, z = 198, wait = 5000 },
                { x = -320, y = 0, z = 198, wait = 5000 },
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

    for k = #ID.mob.ARCHAIC_GEARS, 1, -1 do
        if mobID == ID.mob.ARCHAIC_GEARS[k] then
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
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if instance then
        local stage    = instance:getStage()
        local progress = instance:getProgress()
        local mobID    = mob:getID()

        if stage == 5 and progress == 1 then
            if utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEARS, 1, 8)) then
                mob:delImmunity(xi.immunity.DARK_SLEEP)
                mob:pathThrough(getPath(mob), xi.path.flag.PATROL)
            elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEARS, 9, 12)) then
                mob:delImmunity(xi.immunity.DARK_SLEEP)
                mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 14)
            elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEARS, 13, 24)) then
                mob:pathThrough(getPath(mob), xi.path.flag.PATROL)
            elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEARS, 25, 32)) then
                mob:delImmunity(xi.immunity.DARK_SLEEP)
                mob:pathThrough(getPath(mob), xi.path.flag.PATROL)
            end
        elseif stage == 6 then
            mob:pathThrough(getPath(mob), xi.path.flag.PATROL)
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
