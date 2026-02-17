-----------------------------------
-- func: post
-- desc: どこでもポスト有効時に宅配メニュー（受取/送信）を開く
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

local function printUsage(player)
    player:printToPlayer('!post [recv|send]')
    player:printToPlayer('recv: 受取画面を開く / send: 送付画面を開く')
end

commandObj.onTrigger = function(player, mode)
    -- 運用設定が有効なときのみ、どこでも宅配メニューを開く。
    if not (xi.settings and xi.settings.map and xi.settings.map.POST_ENABLED_ANYWHERE) then
        player:printToPlayer('post: disabled (map.POST_ENABLED_ANYWHERE=false).')
        return
    end

    local m = string.lower(tostring(mode or 'recv'))
    if m == 'recv' then
        player:openRecvBox()
    elseif m == 'send' then
        player:openSendBox()
    else
        player:printToPlayer('post: invalid mode.')
        printUsage(player)
    end
end

return commandObj
