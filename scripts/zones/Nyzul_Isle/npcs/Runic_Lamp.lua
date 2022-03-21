-----------------------------------
-- Area:  Nyzul Isle
-- NPC:   Runic Lamp
-- animition sub 1 == glow
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onTrigger(player, npc)
    local instance = npc:getInstance()
    local chars = instance:getChars()
    local OBJECTIVE = instance:getLocalVar("[Lamps]Objective")
    local lampRegister = instance:getLocalVar("[Lamps]lampRegister")
    local lampOrder = npc:getLocalVar("[Lamp]order")
    local wait = npc:getLocalVar("[Lamp]Wait") - os.time()

    if OBJECTIVE == xi.nyzul.lampsObjective.REGISTER then -- 1 lamp spawns and everyone must touch
        if player:getLocalVar("Register") == 0 then
            player:setLocalVar("Register", 1)
            player:messageSpecial(ID.text.LAMP_CERTIFICATION_REGISTERED)
            instance:setLocalVar("[Lamp]PartySize", instance:getLocalVar("[Lamp]PartySize") -1)
            if instance:getLocalVar("[Lamp]PartySize") == 0 then
                npc:AnimationSub(1)
                instance:setProgress(15)
            end
        else
            player:messageSpecial(ID.text.LAMP_CERTIFICATION_CODE)
        end
    elseif OBJECTIVE == xi.nyzul.lampsObjective.ACTIVATE_ALL then
        if npc:AnimationSub() ~= 1 and wait <= 0 then
            player:messageSpecial(ID.text.LAMP_SAME_TIME)
            player:startOptionalCutscene(3, {[0] = 5, cs_option = {1, 2}})
        elseif npc:AnimationSub() == 1 then
            player:messageSpecial(ID.text.LAMP_ACTIVE)
        else
            player:messageSpecial(ID.text.LAMP_CANNOT_ACTIVATE)
        end
    elseif OBJECTIVE == xi.nyzul.lampsObjective.ORDER then
        if (bit.band(lampRegister, bit.lshift(1,lampOrder)) == 0) then
            player:messageSpecial(ID.text.LAMP_ORDER)
            player:startOptionalCutscene(3, {[0] = 6, cs_option = {1,2}})
        elseif npc:AnimationSub() == 3 then
            player:messageSpecial(ID.text.LAMP_NOT_ALL_ACTIVE)
        elseif instance:getLocalVar("procedureTime") > 0 and instance:getLocalVar("procedureTime") < os.time() then
            player:messageSpecial(ID.text.CONFIRMING_PROCEDURE)
        else
            player:messageSpecial(ID.text.LAMP_CANNOT_ACTIVATE)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    local instance = npc:getInstance()
    local OBJECTIVE = instance:getLocalVar("[Lamps]Objective")
    local lampCount = instance:getLocalVar("[Lamp]count") +1
    local pressCount = instance:getLocalVar("[Lamp]pressCount")
    local lampOrder = npc:getLocalVar("[Lamp]order")
    local lampRegister = instance:getLocalVar("[Lamps]lampRegister")
    local winCondition = false

    if csid == 3 and option == 1 then
        if OBJECTIVE == xi.nyzul.lampsObjective.ACTIVATE_ALL then
            npc:AnimationSub(1)
            npc:timer(xi.settings.ACTIVATE_LAMP_TIME, function(npc) npc:AnimationSub(0) npc:setLocalVar("[Lamp]Wait", os.time() + 30) end)
            if instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_1, 0xFFF), xi.objType.NPC):AnimationSub() == 1 and
            instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_2, 0xFFF), xi.objType.NPC):AnimationSub() == 1 and
            instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_3, 0xFFF), xi.objType.NPC):AnimationSub() == 1 then
                if lampCount == 3 then
                    instance:setProgress(15)
                elseif instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_4, 0xFFF), xi.objType.NPC):AnimationSub() == 1 then
                    if lampCount == 4 then
                        instance:setProgress(15)
                    elseif instance:getEntity(bit.band(ID.npc.RUNIC_LAMP_5, 0xFFF), xi.objType.NPC):AnimationSub() == 1 then
                        instance:setProgress(15)
                    end
                end
            end
        end
    elseif csid == 3 and option == 2 then
        if OBJECTIVE == xi.nyzul.lampsObjective.ORDER then
            print("registering lamp, register: "..instance:getLocalVar("[Lamps]lampRegister"))
            lampRegister = lampRegister + bit.lshift(1, lampOrder)
            instance:setLocalVar("[Lamps]lampRegister", lampRegister)
            instance:setLocalVar("[Lamp]pressCount", pressCount + 1)
            npc:setLocalVar("[Lamp]press", pressCount + 1)
--            print("lamp registered, register: "..instance:getLocalVar("[Lamps]lampRegister"))
--            print("lamp count: "..instance:getLocalVar("[Lamp]count").." press count: "..instance:getLocalVar("[Lamp]pressCount"))

            if lampCount == 3 and lampRegister > 13 then
                for i = ID.npc.RUNIC_LAMP_1, ID.npc.RUNIC_LAMP_3 do
                    local lamp = instance:getEntity(bit.band(i, 0xFFF), xi.objType.NPC)
                    local lampPress = lamp:getLocalVar("[Lamp]press")
                    local setOrder = lamp:getLocalVar("[Lamp]order")
--                    print("lamp: "..i.." lampPress: "..lampPress.." setOrder: "..setOrder)
                    lamp:AnimationSub(1)
                    if lampPress ~= setOrder then
                        lamp:timer(10000, function(lamp)
                            lamp:AnimationSub(0)
                            instance:setLocalVar("[Lamps]lampRegister", 0)
                            instance:setLocalVar("[Lamp]pressCount", 0)
                        end)
                    else
                        instance:setLocalVar("lampsCorrect", instance:getLocalVar("lampsCorrect") + 1)
                    end
                end
                if instance:getLocalVar("lampsCorrect") == 3 then
                    winCondition = true
                else
                    instance:setLocalVar("lampsCorrect", 0)
                end
            elseif lampCount == 4 and lampRegister > 29 then
                for i = ID.npc.RUNIC_LAMP_1, ID.npc.RUNIC_LAMP_4 do
                    local lamp = instance:getEntity(bit.band(i, 0xFFF), xi.objType.NPC)
                    local lampPress = lamp:getLocalVar("[Lamp]press")
                    local setOrder = lamp:getLocalVar("[Lamp]order")
--                    print("lamp: "..i.." lampPress: "..lampPress.." setOrder: "..setOrder)
                    lamp:AnimationSub(1)
                    if lampPress ~= setOrder then
                        lamp:timer(10000, function(lamp)
                            lamp:AnimationSub(0)
                            instance:setLocalVar("[Lamps]lampRegister", 0)
                            instance:setLocalVar("[Lamp]pressCount", 0)
                        end)
                    else
                        instance:setLocalVar("lampsCorrect", instance:getLocalVar("lampsCorrect") + 1)
                    end
                end
                if instance:getLocalVar("lampsCorrect") == 4 then
                    winCondition = true
                else
                    instance:setLocalVar("lampsCorrect", 0)
                end
            elseif lampCount == 5 and lampRegister > 61 then
                for i = ID.npc.RUNIC_LAMP_1, ID.npc.RUNIC_LAMP_5 do
                    local lamp = instance:getEntity(bit.band(i, 0xFFF), xi.objType.NPC)
                    local lampPress = lamp:getLocalVar("[Lamp]press")
                    local setOrder = lamp:getLocalVar("[Lamp]order")
--                    print("lamp: "..i.." lampPress: "..lampPress.." setOrder: "..setOrder)
                    lamp:AnimationSub(1)
                    if lampPress ~= setOrder then
                        lamp:timer(10000, function(lamp)
                            lamp:AnimationSub(0)
                            instance:setLocalVar("[Lamps]lampRegister", 0)
                            instance:setLocalVar("[Lamp]pressCount", 0)
                        end)
                    else
                        instance:setLocalVar("lampsCorrect", instance:getLocalVar("lampsCorrect") + 1)
                    end
                end
                if instance:getLocalVar("lampsCorrect") == 5 then
                    winCondition = true
                else
                    instance:setLocalVar("lampsCorrect", 0)
                end
            end
            if winCondition == true then
                instance:setLocalVar("procedureTime", os.time() + 6)
                npc:timer(6000, function(npc)
                    instance:setLocalVar("lampsCorrect", 0)
                    instance:setLocalVar("[Lamps]lampRegister", 0)
                    instance:setLocalVar("[Lamp]pressCount", 0)
                    instance:setLocalVar("procedureTime", 0)
                    instance:setProgress(15)
                end)
            end
        end
    end
end