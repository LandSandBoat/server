-- Zone: Outer Horutoto Ruins (194)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

-----------------------------------
-- local functions
-----------------------------------

local function setTrioCooldown()
    local pop = os.time() + math.random(2700, 3600) -- 45 to 60 minutes

    for i = ID.mob.BALLOON_NM_OFFSET + 1, ID.mob.BALLOON_NM_OFFSET + 3 do
        GetMobByID(i):setLocalVar("pop", pop)
    end
end

local function trioPrimed()
    for i = ID.mob.BALLOON_NM_OFFSET + 1, ID.mob.BALLOON_NM_OFFSET + 3 do
        local nm = GetMobByID(i)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end

    return false
end

local darkOrbKI =
{
    xi.ki.FIRST_DARK_MANA_ORB,
    xi.ki.SECOND_DARK_MANA_ORB,
    xi.ki.THIRD_DARK_MANA_ORB,
    xi.ki.FOURTH_DARK_MANA_ORB,
    xi.ki.FIFTH_DARK_MANA_ORB,
    xi.ki.SIXTH_DARK_MANA_ORB,
}

local glowingOrbKI =
{
    xi.ki.FIRST_GLOWING_MANA_ORB,
    xi.ki.SECOND_GLOWING_MANA_ORB,
    xi.ki.THIRD_GLOWING_MANA_ORB,
    xi.ki.FOURTH_GLOWING_MANA_ORB,
    xi.ki.FIFTH_GLOWING_MANA_ORB,
    xi.ki.SIXTH_GLOWING_MANA_ORB,
}

-----------------------------------
-- public functions
-----------------------------------

OUTER_HORUTOTO_RUINS = {
    --[[..............................................................................................
        check to spawn trio NM.
        ..............................................................................................]]
    balloonOnDespawn = function(mob)
        local phId = mob:getID()
        local offset = phId - ID.mob.BALLOON_NM_OFFSET

        if offset >= 0 and offset <= 4 and not trioPrimed() and math.random(100) <= 20 then
            local nmId = ID.mob.BALLOON_NM_OFFSET + math.random(1, 3)
            local nm = GetMobByID(nmId)
            local pop = nm:getLocalVar("pop")

            if os.time() > pop then
                -- print(string.format("ph %i winner! nm %i will pop in place", phId, nmId))
                DisallowRespawn(phId, true)
                DisallowRespawn(nmId, false)
                UpdateNMSpawnPoint(nmId)
                nm:setRespawnTime(GetMobRespawnTime(phId))

                nm:addListener("DESPAWN", "DESPAWN_"..nmId, function(m)
                    -- print(string.format("nm %i died. ph %i will pop in place", nmId, phId))
                    DisallowRespawn(nmId, true)
                    DisallowRespawn(phId, false)
                    GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
                    m:removeListener("DESPAWN_"..nmId)
                    setTrioCooldown()
                end)
            end
        end
    end,

    --[[..............................................................................................
        player clicks on magical gizmo
        ..............................................................................................]]
    gizmoOnTrigger = function(player, npc)
        local gizmoNum = npc:getID() - ID.npc.GATE_MAGICAL_GIZMO -- gizmoNum will be 1 through 6
        local msgBase = ID.text.ORB_ALREADY_PLACED

        if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_HEART_OF_THE_MATTER then
            local missionStatus = player:getMissionStatus(player:getNation())

            -- placing dark mana orbs
            if missionStatus == 2 then
                if player:getCharVar("MissionStatus_orb" .. gizmoNum) == 1 then
                    player:startEvent(57 + gizmoNum)
                else
                    player:messageSpecial(msgBase)
                end

            -- collecting energized mana orbs
            elseif missionStatus == 4 then
                if player:getCharVar("MissionStatus_orb" .. gizmoNum) == 2 then
                    player:startEvent(45 + gizmoNum)
                else
                    player:messageSpecial(msgBase + 3)
                end

            else
                player:messageSpecial(msgBase + 12)
            end
        else
            player:messageSpecial(msgBase + 12)
        end
    end,

    --[[..............................................................................................
        magical gizmo event finish
        ..............................................................................................]]
    gizmoOnEventFinish = function(player, csid)
        local npc = player:getEventTarget()

        if npc then
            local gizmoNum = npc:getID() - ID.npc.GATE_MAGICAL_GIZMO
            local msgBase = ID.text.ORB_ALREADY_PLACED
            local orbVal = player:getCharVar("MissionStatus_orb" .. gizmoNum)

            -- placing dark mana orbs
            if csid == (57 + gizmoNum) then
                if orbVal == 1 then
                    local ki = darkOrbKI[gizmoNum]

                    player:setCharVar("MissionStatus_orb" .. gizmoNum, 2)
                    player:messageSpecial(msgBase + 1, 0, 0, ki) -- "The <ki> has been placed into the receptacle."
                    player:delKeyItem(ki)

                    -- Check if all orbs have been placed or not
                    if
                        player:getCharVar("MissionStatus_orb1") == 2 and
                        player:getCharVar("MissionStatus_orb2") == 2 and
                        player:getCharVar("MissionStatus_orb3") == 2 and
                        player:getCharVar("MissionStatus_orb4") == 2 and
                        player:getCharVar("MissionStatus_orb5") == 2 and
                        player:getCharVar("MissionStatus_orb6") == 2
                    then
                        player:messageSpecial(msgBase + 5) -- "You have set all of the Dark Mana Orbs in place."
                        player:setMissionStatus(player:getNation(), 3)
                    end
                end

            -- collecting energized mana orbs
            elseif csid == (45 + gizmoNum) then
                if orbVal == 2 then
                    local ki = glowingOrbKI[gizmoNum]

                    player:setCharVar("MissionStatus_orb" .. gizmoNum, 3)
                    player:addKeyItem(ki)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)

                    if
                        player:getCharVar("MissionStatus_orb1") == 3 and
                        player:getCharVar("MissionStatus_orb2") == 3 and
                        player:getCharVar("MissionStatus_orb3") == 3 and
                        player:getCharVar("MissionStatus_orb4") == 3 and
                        player:getCharVar("MissionStatus_orb5") == 3 and
                        player:getCharVar("MissionStatus_orb6") == 3
                    then
                        player:messageSpecial(msgBase + 4)
                        player:setMissionStatus(player:getNation(), 5)
                    end
                end
            end
        end
    end,
}

return OUTER_HORUTOTO_RUINS
