-----------------------------------
-- Area: Xarcabard
--   NM: Boreal Tiger
-- Involved in Quests: Atop the Highest Mountains
-- !pos 341 -29 370 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 343.35, y = -28.87, z = 375.09, }, -- 1
    { x = 341.02, y = -29.66, z = 370.29, }, -- 2 (Origin)
    { x = 338.78, y = -30.00, z = 365.52, }, -- 3
    { x = 339.92, y = -30.00, z = 358.61, }, -- 4
    { x = 339.50, y = -30.39, z = 351.29, }, -- 5
    { x = 340.52, y = -28.85, z = 343.67, }, -- 6
    { x = 343.43, y = -28.58, z = 337.09, }, -- 7
    { x = 340.52, y = -28.85, z = 343.67, }, -- 6
    { x = 339.50, y = -30.39, z = 351.29, }, -- 5
    { x = 339.92, y = -30.00, z = 358.61, }, -- 4
    { x = 338.78, y = -30.00, z = 365.52, }, -- 3
    { x = 341.02, y = -29.66, z = 370.29, }, -- 2 (Origin)
}

entity.onMobSpawn = function(mob)
    -- Failsafe to make sure NPC is down when NM is up
    if xi.settings.main.OLDSCHOOL_G2 then
        GetNPCByID(ID.npc.BOREAL_TIGER_QM):showNPC(0)
    end
end

entity.onMobRoam = function(mob)
    local PathingIndex = mob:getLocalVar('PathingIndex')
    local ResumePathingIndex = mob:getLocalVar('ResumePathingIndex')
    
    if mob:isFollowingPath() then
        mob:setLocalVar('ResumePathingIndex', os.time() + 4) -- Make sure mob is waiting 4 seconds to path after stopping
    elseif (os.time() > ResumePathingIndex) then
        if (math.random() > .25) then
            PathingIndex = PathingIndex + math.random(1,3)
        else
            PathingIndex = PathingIndex - math.random(1,3)
        end
            
        PathingIndex = utils.clamp(PathingIndex % #pathNodes, 1, #pathNodes) -- Keep PathingIndex between the valid range
        mob:setLocalVar('PathingIndex', PathingIndex)
        mob:setLocalVar('ResumePathingIndex', os.time() + 6) -- Make sure mob is waiting at least 6 seconds to path after it's last stop
        mob:pathTo(pathNodes[PathingIndex].x, pathNodes[PathingIndex].y, pathNodes[PathingIndex].z, xi.path.flag.RUN)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if xi.settings.main.OLDSCHOOL_G2 then
        -- show ??? for desired duration
        -- notify people on the quest who need the KI
        GetNPCByID(ID.npc.BOREAL_TIGER_QM):showNPC(xi.settings.main.FRIGICITE_TIME)
        if
            not player:hasKeyItem(xi.ki.ROUND_FRIGICITE) and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:messageSpecial(ID.text.BLOCKS_OF_ICE)
        end
    end
end

return entity
