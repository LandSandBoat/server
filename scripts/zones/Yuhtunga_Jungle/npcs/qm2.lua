-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: ??? (Tuning Out)
-- !pos 362.586 3.999 220.106 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local function isFightInProgress()
    return GetMobByID(ID.mob.NASUS_OFFSET):isAlive()
        or GetMobByID(ID.mob.NASUS_OFFSET + 1):isAlive()
        or GetMobByID(ID.mob.NASUS_OFFSET + 2):isAlive()
        or GetMobByID(ID.mob.NASUS_OFFSET + 3):isAlive()
        or GetMobByID(ID.mob.NASUS_OFFSET + 4):isAlive()
end

local function spawnNMs(player)
    local qm = GetNPCByID(ID.npc.TUNING_OUT_QM)
    if not isFightInProgress() then
        qm:setLocalVar("cooldown", os.time() + 900) -- 15 minutes between repops
        qm:setLocalVar("NasusKilled", 0)
        qm:setLocalVar("QuestPlayer", player:getID()) -- only the person who pops will complete quest

        npcUtil.popFromQM(player, qm, {
            ID.mob.NASUS_OFFSET,
            ID.mob.NASUS_OFFSET + 1,
            ID.mob.NASUS_OFFSET + 2,
            ID.mob.NASUS_OFFSET + 3,
            ID.mob.NASUS_OFFSET + 4
        }, { claim = true, hide = 0 })

        player:messageText(qm, ID.text.SWARM_APPEARED, false)
    end
end

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    if
        tuningOutProgress == 4 and
        npc:getLocalVar("QuestPlayer") == player:getID() and
        npc:getLocalVar("NasusKilled") == 5
    then -- player killed 5 Nasus and was the one to pop
        player:startEvent(29)

    elseif tuningOutProgress == 3 or tuningOutProgress == 4 then
        if os.time() >= npc:getLocalVar("cooldown") then
            -- Only show CS if first time spawning mobs
            if tuningOutProgress == 3 then
                player:startEvent(28)
            else
                spawnNMs(player)
            end
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid)
    if csid == 28 then -- initiate fight
        player:setCharVar("TuningOut_Progress", 4)
        spawnNMs(player)

    elseif csid == 29 then -- after fight
        player:setCharVar("TuningOut_Progress", 5)
    end
end

return entity
