-----------------------------------
-- NPC: Dormant Rampart
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

local pos =
{
    [1] =
    {
        [1] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 420, 16, -291,  64 },
        },
        [2] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 451, 16, -460, 255 },
        },
        [3] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 260, 16, -291,  64 },
        },
        [4] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 229, 16, -460, 129 },
        },
    },
    [2] =
    {
        [1] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = {  309, -4, 260,  0 },
        },
        [2] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = { 340, -4, 229, 197 },
        },
        [3] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = { 371, -4, 260, 126 },
        },
        [4] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = { 340, -4,  291, 63 },
        },
    },
    [3] =
    {
        [1] =
        {
            enter = { 260, 0.5, 114 , 192 },
            exit  = { -300, -4, -420,   0 },
        },
        [2] =
        {
            enter = { 260, 0.5,  114, 192 },
            exit  = { -380, -4, -420, 128 },
        },
    },
    [4] =
    {
        [1] =
        {
            enter = { 420,  0, 114, 192 },
            exit  = { -300, 0, -75, 192 },
        },
        [2] =
        {
            enter = { 420, 0, 114, 192 },
            exit  = { -315, -4, 20,  0 },
        },
        [3] =
        {
            enter = {  420,  0, 114, 192 },
            exit  = { -220, -4, 125, 192 },
        },
        [4] =
        {
            enter = { 420,  0, 114, 192 },
            exit  = { -300, 0, 195,  64 },
        },
        [5] =
        {
            enter = {  420, 0, 114, 192 },
            exit  = { -380, 0, -75, 192 },
        },
        [6] =
        {
            enter = {  420, 0, 114, 192 },
            exit  = { -365, -4, 20, 128 },
        },
        [7] =
        {
            enter = {  420,  0, 114, 192 },
            exit  = { -460, -4, 125, 192 },
        },
        [8] =
        {
            enter = {  420, 0, 114, 192 },
            exit  = { -380, 0, 195,  64 },
        },
    },
}

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
            local stage = instance:getStage()
            local section = instance:getLocalVar('dormantArea')
            local sendTo = pos[stage][section].enter

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
