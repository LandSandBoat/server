-----------------------------------
-- func: post
-- desc: どこでもポスト有効時に宅配メニュー（送信）を開く
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ''
}

commandObj.onTrigger = function(player)
    -- 運用設定が有効なときのみ、どこでも宅配メニューを開く。
    if not (xi.settings and xi.settings.map and xi.settings.map.POST_ENABLED_ANYWHERE) then
        player:printToPlayer('post: disabled (map.POST_ENABLED_ANYWHERE=false).')
        return
    end

    player:openSendBox()
end

return commandObj

