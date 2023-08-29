-----------------------------------
-- Area:  Nyzul Isle
-- NPC:   Rune of Transfer
-- Notes: Displays currentFloor floor objective, activates when objective completed.
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/nyzul")
require("scripts/globals/utils")
require("scripts/zones/Nyzul_Isle/instances/nyzul_isle_investigation")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if npc:getAnimationSub() == 1 and npc:getLocalVar("cued") == 0 then
        if instance:getLocalVar("menuChoice") > 1 then
            -- Normal Menu
            player:startOptionalCutscene(201, { [0] = 7, cs_option = { 1, 2 } })
        else
            -- Left / Right Menu
            player:startOptionalCutscene(201, { [0] = 27, cs_option = { 1, 2 } })
        end
    elseif npc:getAnimationSub() == 0 then
        npc:messageText(npc, ID.text.OBJECTIVE_TEXT_OFFSET + instance:getStage(), false)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- Setup 1st person to activate rune to go up to control the porting to next floor
    local instance = player:getInstance()

    if
        csid == 201 and
        option ~= 1073741824 and
        instance:getLocalVar("runeHandler") == 0
    then
        local chars = instance:getChars()
        instance:setLocalVar("runeHandler", player:getID())

        for _, entities in pairs(chars) do
            if entities:isInEvent() and entities:getID() ~= player:getID() then
                entities:release()
            end

            entities:setLocalVar("Register", 0)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local instance = npc:getInstance()
    local chars    = instance:getChars()
    local mobs     = instance:getMobs()

    if csid == 1 then
        for _, players in ipairs(chars) do
            players:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    elseif
        csid == 201 and
        option ~= 1073741824 and
        instance:getLocalVar("runeHandler") == player:getID()
    then
        -- Leave Assault
        if option == 1 and npc:getLocalVar("runCompleted") == 0 then
            npc:setLocalVar("runCompleted", 1)
            local currentFloor = utils.clamp(xi.nyzul.getRelativeFloor(instance), 1, 100)
            local startFloor   = instance:getLocalVar("Nyzul_Isle_StartingFloor")
            local diskHolder   = instance:getLocalVar("diskHolder")

            for _, players in pairs(chars) do
                local floorProgress = players:getVar("NyzulFloorProgress")

                if not xi.settings.main.RUNIC_DISK_SAVE then
                    -- Only the person who chose floor gets disk recoreded
                    if players:getID() == diskHolder then
                        if (floorProgress + 1) >= startFloor and floorProgress < currentFloor then
                            players:setVar("NyzulFloorProgress", currentFloor)
                            players:messageSpecial(ID.text.FLOOR_RECORD, xi.ki.RUNIC_DISC, currentFloor)
                        end
                    end
                else
                    -- Everyone gets to save disk info
                    if players:hasKeyItem(xi.ki.RUNIC_DISC) then
                        if (floorProgress + 1) >= startFloor and floorProgress < currentFloor then
                            players:setVar("NyzulFloorProgress", currentFloor)
                            players:messageSpecial(ID.text.FLOOR_RECORD, xi.ki.RUNIC_DISC, currentFloor)
                        end
                    end
                end

                local tokens = math.max(0, instance:getLocalVar("potential_tokens") - xi.nyzul.getTokenPenalty(instance))

                -- Assault initiator gets 10% more tokens
                if players:getID() == instance:getLocalVar("assaultInitiator") then
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

        if option >= 2 and npc:getLocalVar("cued") == 0 then
            npc:setLocalVar("cued", 1)
            local currentFloor = instance:getLocalVar("Nyzul_Current_Floor")

            if currentFloor == 100 then
                instance:setLocalVar("Nyzul_Current_Floor", 1)
            else
                instance:setLocalVar("Nyzul_Current_Floor", currentFloor + 1)
            end

            for _, enemy in ipairs(mobs) do
                DespawnMob(enemy:getID(), instance)
            end

            if instance:getStage() == xi.nyzul.objective.ACTIVATE_ALL_LAMPS then
                for i = ID.npc.RUNIC_LAMP_OFFSET, ID.npc.RUNIC_LAMP_OFFSET + 4 do
                    GetNPCByID(i, instance):setStatus(xi.status.DISAPPEAR)
                    GetNPCByID(i, instance):setAnimationSub(0)
                end
            end

            for _, entities in pairs(chars) do
                entities:timer(1500, function(char)
                    char:startCutscene(95)
                end)
            end

            -- left/right Menu
            if option > 2 and math.random(100) >= 50 then
                instance:setLocalVar("randomPathos", math.random(18, 29))
            end

            xi.nyzul.clearChests(instance)
            npc:timer(8000, function(rune)
                rune:setAnimationSub(0)
                rune:setStatus(xi.status.DISAPPEAR)
                rune:setLocalVar("cued", 0)
            end)
        end
    end
end

return entity
