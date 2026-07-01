-----------------------------------
-- Tutorial Mini-Quest
-----------------------------------
xi = xi or {}
xi.tutorial = xi.tutorial or {}

xi.tutorial.onTrigger = function(player, npc, npc_event_offset, nation_offset)
    local stage = player:getCharVar('TutorialProgress')
    if stage == 1 then
        player:startEvent(npc_event_offset + 22)                -- Tutorial NPC introduces themselves.
    else
        local mLevel = player:getMainLvl()
        local sLevel = player:getSubLvl()
        if stage == 2 then
            player:startEvent(npc_event_offset)                 -- Tutorial NPC instructs you to get Signet.
        elseif stage == 3 then
            if not player:hasStatusEffect(xi.effect.SIGNET) then
                player:startEvent(npc_event_offset + 1)         -- You talked to them without Signet.
            else
                player:startEvent(npc_event_offset + 2)         -- Tutorial NPC asks you to eat.
            end
        elseif stage == 4 then
            if not player:hasStatusEffect(xi.effect.FOOD) then
                player:startEvent(npc_event_offset + 3)         -- You talked to them without eating.
            else
                player:startEvent(npc_event_offset + 4)         -- Tutorial NPC asks you to learn a weaponskill.
            end
        elseif stage == 5 then
            local isSkilled = false
            for i = xi.skill.HAND_TO_HAND, xi.skill.STAFF do
                if player:getSkillLevel(i) >= 5 then
                    isSkilled = true
                    break
                end
            end

            if not isSkilled then
                player:startEvent(npc_event_offset + 5)         -- You talked without having any weaponskills.
            else
                player:startEvent(npc_event_offset + 6)         -- Tutorial NPC asks you to activate Records of Eminence.
            end
        elseif stage == 6 then
            if not player:hasKeyItem(xi.ki.MEMORANDOLL) then
                player:startEvent(npc_event_offset + 7)         -- You didn't get your memorandoll.
            else
                player:startEvent(npc_event_offset + 8)         -- Tutorial NPC asks you to poke an auction house counter.
            end
        elseif stage == 7 then
            player:startEvent(npc_event_offset + 9)             -- You haven't yet found an auction house.
        elseif stage == 8 then
            player:startEvent(npc_event_offset + 10)            -- Tutorial NPC asks you to reach level 5.
        elseif stage == 9 then
            if mLevel < 5 then
                player:startEvent(npc_event_offset + 11)        -- Your main job is below level 5.
            else
                player:startEvent(npc_event_offset + 12)        -- Tutorial NPC asks you to get a trust permit.
            end
        elseif stage == 10 then                                 -- Logic to determine if you have a trust permit from the same nation as the Tutorial NPC.
            local nationKiParam = 0
            if player:getZoneID() == xi.zone.BASTOK_MARKETS then
                nationKiParam = 2
            elseif player:getZoneID() == xi.zone.SOUTHERN_SAN_DORIA then
                nationKiParam = 4
            end
            if not player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT + nationKiParam) then
                player:startEvent(npc_event_offset + 13)        -- You don't have a trust permit from the nation of this NPC yet.
            else
                player:startEvent(npc_event_offset + 14)        -- Tutorial NPC asks you to learn how to teleport.
            end
        -- Captures indicate nation offset begins being sent with events here.
        -- This does make a difference in dialogue when discussing Konschtat Highlands, La Theine Plateau, Tahrongi Canyon, Selbina, and Mhaura.
        -- Unclear if it makes a difference in dialogue for other events, included here to be certain retail behavior is followed.
        elseif
            stage == 11 or
            stage == 12
        then
            player:startEvent(npc_event_offset + 15, nation_offset)     -- You haven't touched the survival guides in the correct order yet.
        elseif
            stage == 13 or
            stage == 14
        then
            player:startEvent(npc_event_offset + 16, nation_offset)     -- Tutorial NPC asks you to reach level 18.
        elseif stage == 15 then
            if mLevel < 18 then
                player:startEvent(npc_event_offset + 17)                -- Your main job is not yet level 18.
                -- Capture shows no offset sent here.
            else
                player:startEvent(npc_event_offset + 18, nation_offset) -- Tutorial NPC asks you to unlock your support job.
            end
        elseif stage == 16 then
            if sLevel < 1 then
                player:startEvent(npc_event_offset + 19, nation_offset) -- You haven't set a subjob yet.
            else
                player:startEvent(npc_event_offset + 20)                -- Tutorial NPC congratulates you for finishing all their tasks.
            end
        elseif stage == 17 then
            player:startEvent(npc_event_offset + 21)                    -- Tutorial NPC post-tutorial dialogue.
        end
    end
end

xi.tutorial.onAuctionTrigger = function(player)
    if player:getCharVar('TutorialProgress') == 7 then
        player:setCharVar('TutorialProgress', 8)
    end
end

xi.tutorial.onGuideTriggerFirst = function(player)
    if player:getCharVar('TutorialProgress') == 11 then
        player:setCharVar('TutorialProgress', 12)
    end
end

xi.tutorial.onGuideTriggerSecond = function(player)
    if player:getCharVar('TutorialProgress') == 12 then
        player:setCharVar('TutorialProgress', 13)
    end
end

xi.tutorial.onEventFinish = function(player, csid, option, npc_event_offset, nation_offset)
    if csid == (npc_event_offset + 22) then
        player:setCharVar('TutorialProgress', 2)
    elseif csid == npc_event_offset then
        player:setCharVar('TutorialProgress', 3)
    elseif csid == (npc_event_offset + 2) then
        if npcUtil.giveItem(player, { { xi.item.STRIP_OF_MEAT_JERKY, 6 } }) then
            player:setCharVar('TutorialProgress', 4)
        end
    elseif csid == (npc_event_offset + 4) then
        player:setCharVar('TutorialProgress', 5)
    elseif csid == (npc_event_offset + 6) then
        npcUtil.giveCurrency(player, 'gil', 100 * xi.settings.main.GIL_RATE)
        player:setCharVar('TutorialProgress', 6)
    elseif csid == (npc_event_offset + 8) then
        if player:getZoneID() == xi.zone.WINDURST_WOODS then
            if npcUtil.giveItem(player, { { xi.item.BIRD_EGG, 1 }, { xi.item.POT_OF_HONEY, 1 }, { xi.item.WATER_CRYSTAL, 1 } }) then
                player:setCharVar('TutorialProgress', 7)
            end
        elseif player:getZoneID() == xi.zone.BASTOK_MARKETS then
            if npcUtil.giveItem(player, { { xi.item.LIZARD_TAIL, 1 }, { xi.item.POT_OF_HONEY, 1 }, { xi.item.FIRE_CRYSTAL, 1 } }) then
                player:setCharVar('TutorialProgress', 7)
            end
        elseif player:getZoneID() == xi.zone.SOUTHERN_SAN_DORIA then
            if npcUtil.giveItem(player, { { xi.item.CHUNK_OF_ROCK_SALT, 1 }, { xi.item.SLICE_OF_HARE_MEAT, 1 }, { xi.item.FIRE_CRYSTAL, 1 } }) then
                player:setCharVar('TutorialProgress', 7)
            end
        end
    elseif csid == (npc_event_offset + 10) then
        npcUtil.giveKeyItem(player, xi.ki.CONQUEST_PROMOTION_VOUCHER)
        player:setCharVar('TutorialProgress', 9)
    elseif csid == (npc_event_offset + 12) then
        if npcUtil.giveItem(player, xi.item.RAISING_EARRING) then
            player:setCharVar('TutorialProgress', 10)
        end
    elseif csid == (npc_event_offset + 14) then
        if npcUtil.giveItem(player, xi.item.WARP_RING) then
            player:setCharVar('TutorialProgress', 11)
        end
    elseif csid == (npc_event_offset + 16) then
        if npcUtil.giveItem(player, { { xi.item.SALTENA, 12 } }) then
            player:setCharVar('TutorialProgress', 15)
        end
    elseif csid == (npc_event_offset + 18) then
        npcUtil.giveItem(player, xi.item.COPPER_AMAN_VOUCHER)
        player:setCharVar('TutorialProgress', 16)
    elseif csid == (npc_event_offset + 20) then
        if npcUtil.giveItem(player, { { xi.item.FREE_CHOCOPASS, 12 }, { xi.item.ECHAD_RING, 1 } }) then
            player:setCharVar('TutorialProgress', 17)
        end
    end
end
