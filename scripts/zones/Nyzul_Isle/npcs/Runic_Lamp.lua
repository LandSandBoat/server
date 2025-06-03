-----------------------------------
-- Area:  Nyzul Isle
-- NPC:   Runic Lamp
-- animition sub 1 == glow
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if not instance then
        return
    end

    local lampObjective = instance:getLocalVar('[Lamps]Objective')
    local lampRegister  = instance:getLocalVar('[Lamps]lampRegister')
    local lampOrder     = npc:getLocalVar('[Lamp]order')
    local wait          = npc:getLocalVar('[Lamp]Wait') - os.time()

    -- Type 1 in Nyzul.lua global
    if lampObjective == xi.nyzul.lampsObjective.REGISTER then -- 1 lamp spawns and everyone must touch
        if player:getLocalVar('Register') == 0 then
            player:setLocalVar('Register', 1)
            player:messageSpecial(ID.text.LAMP_CERTIFICATION_REGISTERED)
            instance:setLocalVar('[Lamp]PartySize', instance:getLocalVar('[Lamp]PartySize') -1)

            if instance:getLocalVar('[Lamp]PartySize') == 0 then
                npc:setAnimationSub(1)
                instance:setProgress(15)
            end
        else
            player:messageSpecial(ID.text.LAMP_CERTIFICATION_CODE)
        end

    -- Type 2 in Nyzul.lua global
    elseif lampObjective == xi.nyzul.lampsObjective.ACTIVATE_ALL then
        if npc:getAnimationSub() ~= 1 and wait <= 0 then
            player:messageSpecial(ID.text.LAMP_SAME_TIME)
            player:startOptionalCutscene(3, { [0] = 5, cs_option = { 1, 2 } })
        elseif npc:getAnimationSub() == 1 then
            player:messageSpecial(ID.text.LAMP_ACTIVE)
        else
            player:messageSpecial(ID.text.LAMP_CANNOT_ACTIVATE)
        end

    -- Type 3 in Nyzul.lua global
    elseif lampObjective == xi.nyzul.lampsObjective.ORDER then
        if bit.band(lampRegister, bit.lshift(1, lampOrder)) == 0 then
            player:messageSpecial(ID.text.LAMP_ORDER)
            player:startOptionalCutscene(3, { [0] = 6, cs_option = { 1, 2 } })
        elseif npc:getAnimationSub() == 3 then
            player:messageSpecial(ID.text.LAMP_NOT_ALL_ACTIVE)
        elseif
            instance:getLocalVar('procedureTime') > 0 and
            instance:getLocalVar('procedureTime') < os.time()
        then
            player:messageSpecial(ID.text.CONFIRMING_PROCEDURE)
        else
            player:messageSpecial(ID.text.LAMP_CANNOT_ACTIVATE)
        end
    end
end

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
entity.onEventFinish = function(player, csid, option, npc)
    local instance = npc:getInstance()
    if not instance then
        return
    end

    local lampObjective = instance:getLocalVar('[Lamps]Objective')
    local lampCount     = instance:getLocalVar('[Lamp]count') + 1
    local pressCount    = instance:getLocalVar('[Lamp]pressCount')
    local lampOrder     = npc:getLocalVar('[Lamp]order')
    local lampRegister  = instance:getLocalVar('[Lamps]lampRegister')
    local winCondition  = false

    -- TODO: Change this comment with what is option 1
    if csid == 3 and option == 1 then
        if lampObjective == xi.nyzul.lampsObjective.ACTIVATE_ALL then
            npc:setAnimationSub(1)
            npc:timer(xi.settings.main.ACTIVATE_LAMP_TIME, function(lamp)
                lamp:setAnimationSub(0)
                lamp:setLocalVar('[Lamp]Wait', os.time() + 30)
            end)

            if
                instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_OFFSET, 0xFFF), xi.objType.NPC):getAnimationSub() == 1 and
                instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_OFFSET + 1, 0xFFF), xi.objType.NPC):getAnimationSub() == 1 and
                instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_OFFSET + 2, 0xFFF), xi.objType.NPC):getAnimationSub() == 1
            then
                if lampCount == 3 then
                    instance:setProgress(15)
                elseif instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_OFFSET + 3, 0xFFF), xi.objType.NPC):getAnimationSub() == 1 then
                    if lampCount == 4 then
                        instance:setProgress(15)
                    elseif instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_OFFSET + 4, 0xFFF), xi.objType.NPC):getAnimationSub() == 1 then
                        instance:setProgress(15)
                    end
                end
            end
        end

    -- TODO: Change this comment with what is option 2
    elseif csid == 3 and option == 2 then
        if lampObjective == xi.nyzul.lampsObjective.ORDER then
            print('registering lamp, register: '..instance:getLocalVar('[Lamps]lampRegister'))
            lampRegister = lampRegister + bit.lshift(1, lampOrder)
            instance:setLocalVar('[Lamps]lampRegister', lampRegister)
            instance:setLocalVar('[Lamp]pressCount', pressCount + 1)
            npc:setLocalVar('[Lamp]press', pressCount + 1)
            -- print('lamp registered, register: '..instance:getLocalVar('[Lamps]lampRegister'))
            -- print('lamp count: '..instance:getLocalVar('[Lamp]count')..' press count: '..instance:getLocalVar('[Lamp]pressCount'))

            if lampCount == 3 and lampRegister > 13 then
                for i = ID.npc.RUNIC_LAMP_OFFSET, ID.npc.RUNIC_LAMP_OFFSET + 2 do
                    local lamp = instance:getEntity(bit.band(i, 0xFFF), xi.objType.NPC)

                    if lamp then
                        local lampPress = lamp:getLocalVar('[Lamp]press')
                        local setOrder  = lamp:getLocalVar('[Lamp]order')
                        -- print('lamp: '..i..' lampPress: '..lampPress..' setOrder: '..setOrder)
                        lamp:setAnimationSub(1)

                        if lampPress ~= setOrder then
                            lamp:timer(10000, function(lampNpc)
                                lampNpc:setAnimationSub(0)
                                instance:setLocalVar('[Lamps]lampRegister', 0)
                                instance:setLocalVar('[Lamp]pressCount', 0)
                            end)
                        else
                            instance:setLocalVar('lampsCorrect', instance:getLocalVar('lampsCorrect') + 1)
                        end
                    end
                end

                if instance:getLocalVar('lampsCorrect') == 3 then
                    winCondition = true
                else
                    instance:setLocalVar('lampsCorrect', 0)
                end
            elseif lampCount == 4 and lampRegister > 29 then
                for i = ID.npc.RUNIC_LAMP_OFFSET, ID.npc.RUNIC_LAMP_OFFSET + 3 do
                    local lamp = instance:getEntity(bit.band(i, 0xFFF), xi.objType.NPC)

                    if lamp then
                        local lampPress = lamp:getLocalVar('[Lamp]press')
                        local setOrder  = lamp:getLocalVar('[Lamp]order')
                        -- print('lamp: '..i..' lampPress: '..lampPress..' setOrder: '..setOrder)
                        lamp:setAnimationSub(1)

                        if lampPress ~= setOrder then
                            lamp:timer(10000, function(lampNpc)
                                lampNpc:setAnimationSub(0)
                                instance:setLocalVar('[Lamps]lampRegister', 0)
                                instance:setLocalVar('[Lamp]pressCount', 0)
                            end)
                        else
                            instance:setLocalVar('lampsCorrect', instance:getLocalVar('lampsCorrect') + 1)
                        end
                    end
                end

                if instance:getLocalVar('lampsCorrect') == 4 then
                    winCondition = true
                else
                    instance:setLocalVar('lampsCorrect', 0)
                end
            elseif lampCount == 5 and lampRegister > 61 then
                for i = ID.npc.RUNIC_LAMP_OFFSET, ID.npc.RUNIC_LAMP_OFFSET + 4 do
                    local lamp = instance:getEntity(bit.band(i, 0xFFF), xi.objType.NPC)

                    if lamp then
                        local lampPress = lamp:getLocalVar('[Lamp]press')
                        local setOrder  = lamp:getLocalVar('[Lamp]order')
                        -- print('lamp: '..i..' lampPress: '..lampPress..' setOrder: '..setOrder)
                        lamp:setAnimationSub(1)

                        if lampPress ~= setOrder then
                            lamp:timer(10000, function(lampNpc)
                                lampNpc:setAnimationSub(0)
                                instance:setLocalVar('[Lamps]lampRegister', 0)
                                instance:setLocalVar('[Lamp]pressCount', 0)
                            end)
                        else
                            instance:setLocalVar('lampsCorrect', instance:getLocalVar('lampsCorrect') + 1)
                        end
                    end
                end

                if instance:getLocalVar('lampsCorrect') == 5 then
                    winCondition = true
                else
                    instance:setLocalVar('lampsCorrect', 0)
                end
            end

            -- Finish.
            if winCondition then
                instance:setLocalVar('procedureTime', os.time() + 6)
                npc:timer(6000, function(npcLamp)
                    instance:setLocalVar('lampsCorrect', 0)
                    instance:setLocalVar('[Lamps]lampRegister', 0)
                    instance:setLocalVar('[Lamp]pressCount', 0)
                    instance:setLocalVar('procedureTime', 0)
                    instance:setProgress(15)
                end)
            end
        end
    end
end

return entity
