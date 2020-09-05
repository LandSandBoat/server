-----------------------------------
-- Area: Gustav tunnel
--  NPC: qm2 (???)
-- Note: Part of mission "The Salt of the Earth"
-- !pos -130 1.256 252.696 212
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local basty = player:getCurrentMission(BASTOK)
    local soteStat = player:getCharVar("BASTOK91")

    local anyPlasmsAlive = false
    for i = ID.mob.GIGAPLASM, ID.mob.GIGAPLASM + 14 do
        if (GetMobByID(i):isAlive()) then
            anyPlasmsAlive = true
            break
        end
    end

    if (basty == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and soteStat == 2 and not anyPlasmsAlive) then
        SpawnMob(ID.mob.GIGAPLASM):updateClaim(player)
    elseif (basty == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and soteStat == 3 and not player:hasKeyItem(tpz.ki.MIRACLESALT)) then
        player:addKeyItem(tpz.ki.MIRACLESALT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MIRACLESALT)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
