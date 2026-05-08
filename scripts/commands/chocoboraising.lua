-----------------------------------
-- func: chocoboraising
-- desc: Shows a custom debug menu for interacting with and debugging chocobo raising
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

local epochDay = 86400

commandObj.onTrigger = function(player)
    local sex =
    {
        [0] = 'M',
        [1] = 'F',
    }

    local chocoState = player:getChocoboRaisingInfo()
    local menu =
    {
        title   = '',
        options = {},
    }

    local settingStr = 'Enable'
    if xi.settings.main.ENABLE_CHOCOBO_RAISING then
        settingStr = 'Disable'
    end

    table.insert(menu.options, {
        settingStr,
        function(playerArg)
            xi.settings.main.ENABLE_CHOCOBO_RAISING = not xi.settings.main.ENABLE_CHOCOBO_RAISING
            xi.settings.main.DEBUG_CHOCOBO_RAISING  = not xi.settings.main.DEBUG_CHOCOBO_RAISING
            playerArg:printToPlayer(string.format('Chocobo Raising setting: %s', xi.settings.main.ENABLE_CHOCOBO_RAISING),
                xi.msg.channel.SYSTEM_3, '')
        end,
    })

    if chocoState then
        local stateName = string.format('%s %s [%s]',
            chocoState.first_name,
            chocoState.last_name,
            sex[chocoState.sex])

        menu.title = string.format('Chocobo Raising (%s)', stateName)

        table.insert(menu.options, {
            'Add age (1d)',
            function(playerArg)
                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - epochDay
                playerArg:setChocoboRaisingInfo(info)
                playerArg:printToPlayer('Adding 1 day to state.created', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'Add age (10d)',
            function(playerArg)
                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 10)
                playerArg:setChocoboRaisingInfo(info)
                playerArg:printToPlayer('Adding 10 days to state.created', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'D#1: d0-d4',
            function(playerArg)
                playerArg:deleteRaisedChocobo()

                local egg = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)

                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 4)
                playerArg:setChocoboRaisingInfo(info)

                playerArg:printToPlayer('Setting up debug scenario 1 (4d update)', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'D#2: d0-d10',
            function(playerArg)
                playerArg:deleteRaisedChocobo()

                local egg      = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)

                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 10)
                playerArg:setChocoboRaisingInfo(info)

                if playerArg:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF) then
                    playerArg:delKeyItem(xi.keyItem.WHITE_HANDKERCHIEF)
                end

                playerArg:printToPlayer('Setting up debug scenario 2 (10d update) w/ handkerchief', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'D#3: d0-d65',
            function(playerArg)
                playerArg:deleteRaisedChocobo()

                local egg      = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)

                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 65)
                playerArg:setChocoboRaisingInfo(info)

                playerArg:printToPlayer('Setting up debug scenario 3 (65d update)', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'D#4: d0-d130',
            function(playerArg)
                playerArg:deleteRaisedChocobo()

                local egg      = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)

                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 130)
                playerArg:setChocoboRaisingInfo(info)

                playerArg:printToPlayer('Setting up debug scenario 4 (130d update)', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'Delete chocoState',
            function(playerArg)
                playerArg:deleteRaisedChocobo()
                playerArg:printToPlayer('Deleted chocoState', xi.msg.channel.SYSTEM_3, '')
            end,
        })
    else
        menu.title = 'Chocobo Raising (No chocoState)'

        table.insert(menu.options, {
            'Create default chocoState',
            function(playerArg)
                local egg = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)
                playerArg:printToPlayer('Created default chocoState', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'Give Egg',
            function(playerArg)
                npcUtil.giveItem(playerArg, xi.item.CHOCOBO_EGG_SLIGHTLY_WARM)
            end,
        })
    end

    table.insert(menu.options, {
        'Cancel',
        function(playerArg)
        end,
    })

    player:customMenu(menu)
end

return commandObj
