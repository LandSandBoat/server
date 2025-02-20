-----------------------------------
-- func: getstats
-- desc: prints stats of cursor target into chatlog, for debugging.
-----------------------------------
---@type TCommand
local commandObj = {}

local options =
{
    [1] = 'base',
    [2] = 'defensive',
    [3] = 'offensive',
    [4] = 'elements',
}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.onTrigger = function(player, option)
    local target = player:getCursorTarget()
    if target == nil then
        player:printToPlayer('Target something first.')
        return
    end

    local targetType = target:getObjType()

    if targetType == xi.objType.NPC then
        player:printToPlayer('Target something other than an NPC..They don\'t have stats!')
        return
    end

    -- map integer option to a name for easier reading in if/else for convenient use
    if
        options[tonumber(option)]
    then
        option = options[tonumber(option)]
    end

    player:printToPlayer('Stats for ' .. target:getName(), xi.msg.channel.SYSTEM_3)
    switch(option): caseof
    {
        ['base'] = function()
            player:printToPlayer(string.format('MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ',
                target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), xi.msg.channel.SYSTEM_3)

            player:printToPlayer(string.format('HP: %i/%i  MP: %i/%i (current/max) ',
                target:getHP(), target:getMaxHP(), target:getMP(), target:getMaxMP()), xi.msg.channel.SYSTEM_3)

            player:printToPlayer(string.format('Total STR: %i ', target:getStat(xi.mod.STR)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total DEX: %i ', target:getStat(xi.mod.DEX)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total VIT: %i ', target:getStat(xi.mod.VIT)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total AGI: %i ', target:getStat(xi.mod.AGI)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total MND: %i ', target:getStat(xi.mod.MND)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total INT: %i ', target:getStat(xi.mod.INT)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total CHR: %i ', target:getStat(xi.mod.CHR)), xi.msg.channel.SYSTEM_3)
            if targetType == xi.objType.PC then
                player:printToPlayer(string.format('Total Subtle Blow: %i ', target:getMod(xi.mod.SUBTLE_BLOW)), xi.msg.channel.SYSTEM_3)
                player:printToPlayer(string.format('Total Store TP: %i ', target:getMod(xi.mod.STORETP)), xi.msg.channel.SYSTEM_3)
                player:printToPlayer(string.format('%s\'s base Treasure Hunter with current equipment: %i', target:getName(), target:getMod(xi.mod.TREASURE_HUNTER)), xi.msg.channel.SYSTEM_3)
            elseif targetType == xi.objType.MOB then
                player:printToPlayer(string.format('Mob\'s current Treasure Hunter Tier: %i', target:getTHlevel()), xi.msg.channel.SYSTEM_3)
                player:printToPlayer(string.format('Battletime: %i ', target:getBattleTime()), xi.msg.channel.SYSTEM_3)
            end
        end,

        ['offensive'] = function()
            player:printToPlayer(string.format('Food Accuracy%% bonus: %i ', target:getMod(xi.mod.FOOD_ACCP)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Accuracy Base: %i ', target:getMod(xi.mod.ACC)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total Accuracy: %i ', target:getStat(xi.mod.ACC)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Attack Base: %i ', target:getMod(xi.mod.ATT)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total Attack: %i ', target:getStat(xi.mod.ATT)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Main Weap Dmg: %i ', target:getWeaponDmg()), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('RAccuracy Base: %i ', target:getMod(xi.mod.RACC)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total RAccuracy: %i ', target:getStat(xi.mod.RACC)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Ranged Weap Dmg: %i ', target:getRangedDmg()), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Magic Attack bonus: %i ', target:getMod(xi.mod.MATT)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Magic Accuracy bonus: %i ', target:getMod(xi.mod.MACC)), xi.msg.channel.SYSTEM_3)

            return
        end,

        ['defensive'] = function()
            player:printToPlayer(string.format('EVA Base: %i ', target:getMod(xi.mod.EVA)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('EVA Total: %i ', target:getStat(xi.mod.EVA)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Magic EVA Base: %i ', target:getMod(xi.mod.MEVA)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Defense Base: %i ', target:getMod(xi.mod.DEF)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Total Defense: %i ', target:getStat(xi.mod.DEF)), xi.msg.channel.SYSTEM_3)
            player:printToPlayer(string.format('Magic Defense bonus: %i ', target:getMod(xi.mod.MDEF)), xi.msg.channel.SYSTEM_3)

            return
        end,

        ['elements'] = function()
            local eleMessages = {}
            for k, v in pairs(xi.element) do
                if v > 0 then
                    local message = k
                    -- Right padding to line up lines (not perfect as the font )
                    for i = 1, 8 do
                        if string.len(k) < i then
                            message = ' ' .. message .. ' '
                        end
                    end

                    message = message .. ' SDT: ' ..         target:getMod(xi.combat.element.getElementalSDTModifier(v))
                    message = message .. ' resRank: ' ..     target:getMod(xi.combat.element.getElementalResistanceRankModifier(v))
                    message = message .. ' Null%: ' ..       target:getMod(xi.combat.element.getElementalNullificationModifier(v))
                    message = message .. ' Absorb%: ' ..     target:getMod(xi.combat.element.getElementalAbsorptionModifier(v))
                    message = message .. ' MEva: ' ..        target:getMod(xi.combat.element.getElementalMEVAModifier(v))
                    eleMessages[v] = message
                end
            end

            -- Because pairs(xi.element) doesn't guarantee order
            for _, message in ipairs(eleMessages) do
                player:printToPlayer(message, xi.msg.channel.SYSTEM_3)
            end

            if targetType == xi.objType.MOB then
                -- Print immunities
                local printString = 'Immunities:'
                local hasImmunities = false
                for k, v in pairs(xi.immunity) do
                    if v > 0 then
                        if target:hasImmunity(v) then
                            printString = printString .. ' ' .. k
                            hasImmunities = true
                        end
                    end
                end

                if not hasImmunities then
                    printString = printString .. ' None'
                end

                player:printToPlayer(printString, xi.msg.channel.SYSTEM_3)
            end

            return
        end,

        ['default'] = function()
            -- Not found in switch statement, so we didn't match an option
            local printString = 'Please choose a report type:'
            for k, v in ipairs(options) do
                printString = printString .. ' ' .. v .. '-' .. k
            end

            player:printToPlayer(printString)
            player:printToPlayer('Example: !getstats base or !getstats 1')
        end,
    }
end

return commandObj
