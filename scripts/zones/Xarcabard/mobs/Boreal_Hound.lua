-----------------------------------
-- Area: Xarcabard
--   NM: Boreal Hound
-- Involved in Quests: Atop the Highest Mountains
-- !pos -21 -25 -490 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
local entity = {}
local pathNodes =
{
    { x = -22.73, y = -24.65, z = -496.18, }, --1 
    { x = -21.28, y = -25.58, z = -490.78, }, --2 (Origin)
    { x = -19.06, y = -26.00, z = -485.64, }, --3
    { x = -19.69, y = -26.00, z = -479.90, }, --4
    { x = -18.87, y = -25.38, z = -475.00, }, --5
    { x = -19.82, y = -25.73, z = -473.84, }, --6
    { x = -19.52, y = -26.40, z = -467.73, }, --7
    { x = -21.14, y = -26.26, z = -463.24, }, --8
    { x = -19.52, y = -26.40, z = -467.73, }, --7
    { x = -19.82, y = -25.73, z = -473.84, }, --6
    { x = -18.87, y = -25.38, z = -475.00, }, --5
    { x = -19.69, y = -26.00, z = -479.90, }, --4
    { x = -19.06, y = -26.00, z = -485.64, }, --3
    { x = -21.28, y = -25.58, z = -490.78, }, --2 (Origin)
}

entity.onMobSpawn = function(mob)
    -- Failsafe to make sure NPC is down when NM is up
    if xi.settings.main.OLDSCHOOL_G2 then
        GetNPCByID(ID.npc.BOREAL_HOUND_QM):showNPC(0)
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
        GetNPCByID(ID.npc.BOREAL_HOUND_QM):showNPC(xi.settings.main.FRIGICITE_TIME)
        if
            not player:hasKeyItem(xi.ki.TRIANGULAR_FRIGICITE) and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:messageSpecial(ID.text.BLOCKS_OF_ICE)
        end
    end
end

return entity
