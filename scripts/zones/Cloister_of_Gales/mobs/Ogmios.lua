-----------------------------------
-- Area: Cloister of Gales
--  Mob: Ogmios
-- Involved in Quest: Carbuncle Debacle
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onMobDeath(mob, player, isKiller)

    player:setCharVar("BCNM_Killed", 1)
    record = 300
    partyMembers = 6
    pZone = player:getZoneID()

    player:startEvent(32001, 0, record, 0, (os.time() - player:getCharVar("BCNM_Timer")), partyMembers, 0, 0)

end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)

    if (csid == 32001) then
        player:delStatusEffect(tpz.effect.BATTLEFIELD)
    end

end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 32001) then
        player:delKeyItem(tpz.ki.DAZEBREAKER_CHARM)
    end

end
