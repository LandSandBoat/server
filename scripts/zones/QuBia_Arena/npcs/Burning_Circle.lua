-----------------------------------
-- Area: Qu'Bia Arena
-- NPC:  Burning Circle
-- !pos -221 -24 19 206
-------------------------------------

require("scripts/globals/bcnm")
require("scripts/globals/missions")
require("scripts/globals/keyitems")

-------------------------------------

    -- 0: The Ruins of Fei'Yin, Darkness Rising, The Final Seal (Rank 5 Mission)
    -- 1: Come Into My Parlor
    -- 2: E-vase-ive Action
    -- 3: Infernal Swarm
    -- 4: The Heir to the Light
    -- 5: Shattering Stars (Paladin)
    -- 6: Shattering Stars (Dark Knight)
    -- 7: Shattering Stars (Bard)
    -- 8: Demolition Squad
    -- 9: Die By the Sword
    -- 10: Let Sleeping Dogs Die
    -- 11: Brothers D'Aurphe
    -- 12: Undying Promise
    -- 13: Factory Rejects
    -- 14: Idol Thoughts
    -- 15: An Awful Autopsy
    -- 16: Celery
    -- 17: Mirror Images
    -- 18: A Furious Finale (Dancer)
    -- 19: Clash of the Comrades
    -- 20: Those Who Lurk in the Shadows (III)
    -- 21: Beyond Infinity

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    -- if (player:hasKeyItem(tpz.ki.MARK_OF_SEED) and player:getCurrentMission(ACP) == tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II) then
        --player:startEvent(5)
    --elseif (EventTriggerBCNM(player, npc)) then
    -- Temp disabled pending fixes for the BCNM mobs.

    EventTriggerBCNM(player, npc)
end

function onEventUpdate(player, csid, option, extras)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)

   EventUpdateBCNM(player, csid, option, extras)

end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 5) then
        player:completeMission(ACP, tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II)
        player:addMission(ACP, tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III)
    else
        EventFinishBCNM(player, csid, option)
    end

end
