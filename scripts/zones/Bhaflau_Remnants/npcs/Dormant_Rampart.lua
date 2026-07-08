-----------------------------------
-- NPC: Dormant Rampart
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(3)
end

entity.onEventUpdate = function(player, csid, option, npc)
    local instance = npc:getInstance()

    if instance then
        if csid == 3 and option == 1 then
            local chars = instance:getChars()

            for _, players in ipairs(chars) do
                if players:isInEvent() and players:getID() ~= player:getID() then
                    players:release()
                end
            end
        elseif csid == 5 then
            local stage   = instance:getStage()
            local section = instance:getLocalVar('dormantArea')
            local sendTo  = ID.pos[stage][section].enter
            if sendTo then
                player:setPos(unpack(sendTo))
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local instance = npc:getInstance()

    if instance then
        if csid == 3 and option == 1 and npc:getLocalVar('activated') == 0 then
            local stage = instance:getStage()
            local chars = instance:getChars()

            npc:setLocalVar('activated', 1)
            instance:setLocalVar('destination', 1) -- used for enter logic
            for _, players in ipairs(chars) do
                players:startCutscene(5)
            end

            npc:setAnimationSub(0)
            SpawnMob(ID.mob.REACTION_RAMPART[stage], instance)
        elseif csid == 5 then
            npc:setStatus(xi.status.INVISIBLE)
        end
    end
end

return entity
