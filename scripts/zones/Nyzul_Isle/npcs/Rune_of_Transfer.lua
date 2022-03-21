-----------------------------------
-- Area:  Nyzul Isle
-- NPC:   Rune of Transfer
-- Notes: Displays currentFloor floor objective, activates when objective completed.
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
require("scripts/globals/utils")
require("scripts/zones/Nyzul_Isle/instances/nyzul_isle_investigation")
-----------------------------------

function onTrigger(player, npc)
    local instance = npc:getInstance()

    if npc:AnimationSub() == 1 then
       if instance:getLocalVar("menuChoice") > 1 then
            -- Normal Menu
            player:startOptionalCutscene(201, {[0] = 7, cs_option = {1, 2}})
        else
            -- Left / Right Menu
            player:startOptionalCutscene(201, {[0] = 27, cs_option = {1, 2}})
        end
    elseif npc:AnimationSub() == 0 then
        npc:messageText(npc, ID.text.ELIMINATE_ENEMY_LEADER + instance:getStage(), false)
    end
end

function onEventUpdate(player, csid, option)
    -- Setup 1st person to activate rune to go up to control the porting to next floor
    local instance = player:getInstance()

    if csid == 201 and option ~= 1073741824 and instance:getLocalVar("runeHandler") == 0 then
        local chars = instance:getChars()
        instance:setLocalVar("runeHandler", player:getID())
        for _, entity in pairs(chars) do
            if entity:isInEvent() and entity:getID() ~= player:getID() then
                entity:release()
            end
            entity:setLocalVar("Register", 0)
        end
    end
end

function onEventFinish(player, csid, option, npc)
    local instance = npc:getInstance()
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    if csid == 1 then
        for _, players in ipairs(chars) do
            players:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    elseif csid == 201 and option ~= 1073741824 and instance:getLocalVar("runeHandler") == player:getID() then
        -- Leave Assault
        if option == 1 and npc:getLocalVar("runCompleted") == 0 then
            npc:setLocalVar("runCompleted", 1)
            local currentFloor = utils.clamp(get_relative_floor(instance), 1, 100)
            local startFloor = instance:getLocalVar("Nyzul_Isle_StartingFloor")
            local diskHolder = instance:getLocalVar("diskHolder")

            for _, players in pairs(chars) do
                local floorProgress = players:getVar("NyzulFloorProgress")
                if RUNIC_DISK_SAVE == 0 then
                    -- only the person who chose floor gets disk recoreded
                    if players:getID() == diskHolder then
                        if (floorProgress + 1) >= startFloor and floorProgress < currentFloor then
                            players:setVar("NyzulFloorProgress", currentFloor)
                            players:messageSpecial(ID.text.FLOOR_RECORD, xi.ki.RUNIC_DISC, currentFloor)
                        end
                    end
                else
                    -- everyone gets to save disk info
                    if players:hasKeyItem(xi.ki.RUNIC_DISC) then
                        if (floorProgress + 1) >= startFloor and floorProgress < currentFloor then
                            players:setVar("NyzulFloorProgress", currentFloor)
                            players:messageSpecial(ID.text.FLOOR_RECORD, xi.ki.RUNIC_DISC, currentFloor)
                        end
                    end
                end

                local tokens = math.max(0, instance:getLocalVar("potential_tokens") - nyzul.get_token_penalty(instance))

                -- Assault initiator gets 10% more tokens
                if players:getID() == instance:getLocalVar("assaultInitaitor") then
                    tokens = tokens * 1.1
                end

                -- Adds hidden Assault Points for ranking up in Mercenary Rank
                -- +5 for 1st time +1 for each additional
                if players:hasCompletedAssault(players:getCurrentAssault()) then
                    players:setVar("AssaultPromotion", players:getVar("AssaultPromotion") + 1)
                else
                    players:setVar("AssaultPromotion", players:getVar("AssaultPromotion") + 5)
                end

                players:setVar("AssaultComplete", 1)
                players:addCurrency("nyzul_isle_assault_point", tokens)
                players:messageSpecial(ID.text.OBTAIN_TOKENS, tokens)
                players:startCutscene(1)
            end
        end
        if option >= 2 then
            local currentFloor = instance:getLocalVar("Nyzul_Current_Floor")

            if currentFloor == 100 then
                instance:setLocalVar("Nyzul_Current_Floor", 1)
            else
                instance:setLocalVar("Nyzul_Current_Floor", currentFloor + 1)
            end
            for _, enemy in ipairs(mobs) do
                DespawnMob(enemy:getID(), instance)
            end
            if instance:getStage() == nyzul.objective.ACTIVATE_ALL_LAMPS then
                for i = ID.npc.RUNIC_LAMP_1, ID.npc.RUNIC_LAMP_5 do
                    GetNPCByID(i, instance):setStatus(xi.status.DISAPPEAR)
                    GetNPCByID(i, instance):AnimationSub(0)
                end
            end
            for _, entity in pairs(chars) do
                entity:timer(1500, function(player) entity:startCutscene(95) end)
            end
            -- left/right Menu
            if option > 2 and math.random(100) >= 50 then
                instance:setLocalVar("randomPathos", math.random(18, 29))
            end

            nyzul.clearChests(instance)
            npc:timer(8000, function(npc) npc:AnimationSub(0) npc:setStatus(xi.status.DISAPPEAR) end)
        end
    end
end
