-----------------------------------
--
-- Assault: Golden Salvage
--
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/instance")
-----------------------------------
-- Todo random the chest locations

function afterInstanceRegister(player)
    local instance = player:getInstance()

    player:messageSpecial(ID.text.ASSAULT_41_START, 41)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    local figureheadChest = math.random(ID.npc.ILRUSI_CURSED_CHEST_OFFSET, ID.npc.ILRUSI_CURSED_CHEST_OFFSET + 11)

    for i, v in pairs(ID.mob[1]) do
        SpawnMob(v, instance)
    end

    instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC):setPos(420, -15, 72, 148)
    instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setPos(415, -15, 75, 148)
    instance:getEntity(bit.band(ID.npc._1jp, 0xFFF), tpz.objType.NPC):setAnimation(8)
    instance:getEntity(bit.band(ID.npc._jja, 0xFFF), tpz.objType.NPC):setAnimation(8)
    instance:getEntity(bit.band(ID.npc._jjb, 0xFFF), tpz.objType.NPC):setAnimation(8)

    instance:setProgress(instance:getProgress() + (figureheadChest))

end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC):setStatus(NORMAL)
    instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setStatus(NORMAL)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
