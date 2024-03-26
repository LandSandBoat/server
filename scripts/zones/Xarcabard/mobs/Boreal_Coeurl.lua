-----------------------------------
-- Area: Xarcabard
--   NM: Boreal Coeurl
-- Involved in Quests: Atop the Highest Mountains
-- !pos 580 -9 290 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
local entity = {}

local pathNodes = 
{
    { x = 580.23, y = -9.68,  z = 290.94, }, -- 1 (Origin)
    { x = 578.95, y = -10.00, z = 285.33, }, -- 2
    { x = 581.13, y = -10.00, z = 274.86, }, -- 3
    { x = 578.93, y = -9.52,  z = 268.83, }, -- 4
    { x = 580.00, y = -10.00, z = 260.17, }, -- 5
    { x = 578.93, y = -9.52,  z = 268.83, }, -- 4
    { x = 581.13, y = -10.00, z = 274.86, }, -- 3
    { x = 578.95, y = -10.00, z = 285.33, }, -- 2
    { x = 580.23, y = -9.68,  z = 290.94, }, -- 1 (Origin)
}

entity.onMobSpawn = function(mob)
    -- Failsafe to make sure NPC is down when NM is up
    if xi.settings.main.OLDSCHOOL_G2 then
        GetNPCByID(ID.npc.BOREAL_COEURL_QM):showNPC(0)
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
        GetNPCByID(ID.npc.BOREAL_COEURL_QM):showNPC(xi.settings.main.FRIGICITE_TIME)
        if
            not player:hasKeyItem(xi.ki.SQUARE_FRIGICITE) and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:messageSpecial(ID.text.BLOCKS_OF_ICE)
        end
    end
end

return entity
