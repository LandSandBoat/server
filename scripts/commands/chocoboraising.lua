-----------------------------------
-- func: chocoboraising
-- desc: Shows a custom debug menu for interacting with and debugging chocobo raising
-----------------------------------
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
            'Debug #1',
            function(playerArg)
                playerArg:deleteRaisedChocobo()

                local egg = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)

                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 10)
                playerArg:setChocoboRaisingInfo(info)

                playerArg:printToPlayer('Setting up debug scenario 1 (10d update)', xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'Change sex',
            function(playerArg)
                local info = playerArg:getChocoboRaisingInfo()
                info['sex'] = (info['sex'] + 1) % 2
                playerArg:setChocoboRaisingInfo(info)
                playerArg:printToPlayer('Changed sex to ' .. sex[info['sex']], xi.msg.channel.SYSTEM_3, '')
            end,
        })

        table.insert(menu.options, {
            'Dump chocoState',
            function(playerArg)
                local info = playerArg:getChocoboRaisingInfo()
                playerArg:printToPlayer('created ' .. os.date('%Y %m %d %H %M %S', info['created']), xi.msg.channel.SYSTEM_3, '')
                for k, v in pairs(info) do
                    playerArg:printToPlayer(string.format('%s %s', k, v), xi.msg.channel.SYSTEM_3, '')
                end
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

        table.insert(menu.options, {
            'Debug #1',
            function(playerArg)
                playerArg:deleteRaisedChocobo()

                local egg = {}
                local newChoco = xi.chocoboRaising.newChocobo(playerArg, egg)
                player:setChocoboRaisingInfo(newChoco)

                local info = playerArg:getChocoboRaisingInfo()
                info['created'] = info['created'] - (epochDay * 10)
                playerArg:setChocoboRaisingInfo(info)

                playerArg:printToPlayer('Setting up debug scenario 1 (10d update)', xi.msg.channel.SYSTEM_3, '')
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
