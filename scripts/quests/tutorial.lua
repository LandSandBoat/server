-----------------------------------
-- Tutorial Mini-Quest
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
-----------------------------------

xi = xi or {}
xi.tutorial = xi.tutorial or {}

xi.tutorial.onTrigger = function(player, npc, npc_event_offset, nation_offset)
    local stage = player:getCharVar("TutorialProgress")
    if stage == 0 then
        player:startEvent(npc_event_offset + 17)
    else
        local mLevel = player:getMainLvl()
        if stage == 1 then
            player:startEvent(npc_event_offset)
        elseif stage == 2 then
            if not player:hasStatusEffect(xi.effect.SIGNET) then
                player:startEvent(npc_event_offset + 1)
            else
                player:startEvent(npc_event_offset + 2)
            end
        elseif stage == 3 then
            if not player:hasStatusEffect(xi.effect.FOOD) then
                player:startEvent(npc_event_offset + 3)
            else
                player:startEvent(npc_event_offset + 4)
            end
        elseif stage == 4 then
            local isSkilled = false
            for i = xi.skill.HAND_TO_HAND, xi.skill.STAFF do
                if player:getSkillLevel(i) >= 5 then
                    isSkilled = true
                    break
                end
            end

            if not isSkilled then
                player:startEvent(npc_event_offset + 5)
            else
                player:startEvent(npc_event_offset + 6)
            end
        elseif stage == 5 then
            player:startEvent(npc_event_offset + 7)
        elseif stage == 6 then
            player:startEvent(npc_event_offset + 8, 0, 0, 0, xi.ki.CONQUEST_PROMOTION_VOUCHER, 0, 0, 0)
        elseif stage == 7 then
            if mLevel < 4 then
                player:startEvent(npc_event_offset + 9)
            else
                player:startEvent(npc_event_offset + 10, 0, 0, nation_offset, 0, 0, 0, 0, 0)
            end
        elseif stage == 8 then
            player:startEvent(npc_event_offset + 11, 0, 0, nation_offset, 0, 0, 0, 0, 0)
        elseif stage == 9 then
            player:startEvent(npc_event_offset + 12, 800 * xi.settings.main.EXP_RATE, 0, nation_offset, 0, 0, 0, 0, 0)
        elseif stage == 10 then
            if mLevel < 10 then
                player:startEvent(npc_event_offset + 13, 0, 0, nation_offset, 0, 0, 0, 0, 0)
            else
                player:startEvent(npc_event_offset + 14, 0, 1000 * xi.settings.main.GIL_RATE, nation_offset, 0, 0, 0, 0, 0)
            end
        elseif stage == 11 then
            if not player:hasKeyItem(xi.ki.HOLLA_GATE_CRYSTAL + nation_offset) then
                player:startEvent(npc_event_offset + 15, xi.ki.HOLLA_GATE_CRYSTAL + nation_offset, 0, nation_offset, 0, 0, 0, 0, 0)
            else
                player:startEvent(npc_event_offset + 16, xi.ki.HOLLA_GATE_CRYSTAL + nation_offset, 1000 * xi.settings.main.EXP_RATE, 1789, 3, 0, 0, 0, 0)
            end
        end
    end
end

xi.tutorial.onAuctionTrigger = function(player)
    if player:getCharVar("TutorialProgress") == 5 then
        player:setCharVar("TutorialProgress", 6)
    end
end

xi.tutorial.onEventFinish = function(player, csid, option, npc_event_offset, nation_offset)
    if csid == npc_event_offset then
        player:setCharVar("TutorialProgress", 2)
    elseif csid == (npc_event_offset + 2) then
        if npcUtil.giveItem(player, { { xi.items.STRIP_OF_MEAT_JERKY, 6 } }) then
            player:setCharVar("TutorialProgress", 3)
        end
    elseif csid == (npc_event_offset + 4) then
        player:setCharVar("TutorialProgress", 4)
    elseif csid == (npc_event_offset + 6) then
        if player:getZoneID() == xi.zone.WINDURST_WOODS then
            if npcUtil.giveItem(player, { { xi.items.WATER_CRYSTAL, 1 }, { xi.items.BIRD_EGG, 1 }, { xi.items.POT_OF_HONEY, 1 } }) then
                player:setCharVar("TutorialProgress", 5)
            end
        elseif player:getZoneID() == xi.zone.BASTOK_MARKETS then
            if npcUtil.giveItem(player, { { xi.items.FIRE_CRYSTAL, 1 }, { xi.items.LIZARD_TAIL, 1 }, { xi.items.POT_OF_HONEY, 1 } }) then
                player:setCharVar("TutorialProgress", 5)
            end
        elseif player:getZoneID() == xi.zone.SOUTHERN_SAN_DORIA then
            if npcUtil.giveItem(player, { { xi.items.FIRE_CRYSTAL, 1 }, { xi.items.CHUNK_OF_ROCK_SALT, 1 }, { xi.items.SLICE_OF_HARE_MEAT, 1 } }) then
                player:setCharVar("TutorialProgress", 5)
            end
        end
    elseif csid == (npc_event_offset + 8) then
        npcUtil.giveKeyItem(player, xi.ki.CONQUEST_PROMOTION_VOUCHER)
        player:setCharVar("TutorialProgress", 7)
    elseif csid == (npc_event_offset + 10) then
        if npcUtil.giveItem(player, xi.items.RAISING_EARRING) then
            player:setCharVar("TutorialProgress", 8)
        end
    elseif csid == (npc_event_offset + 12) then
        player:addExp(800 * xi.settings.main.EXP_RATE)
        player:setCharVar("TutorialProgress", 10)
    elseif csid == (npc_event_offset + 14) then
        npcUtil.giveCurrency(player, 'gil', 1000)
        player:setCharVar("TutorialProgress", 11)
    elseif csid == (npc_event_offset + 16) then
        if npcUtil.giveItem(player, { { xi.items.FREE_CHOCOPASS, 3 } }) then
            player:addExp(1000 * xi.settings.main.EXP_RATE)
            player:setCharVar("TutorialProgress", 0)
        end
    end
end

xi.tutorial.onMobDeath = function(player)
    if player and player:getCharVar("TutorialProgress") == 8 then
        player:setCharVar("TutorialProgress", 9)
    end
end
