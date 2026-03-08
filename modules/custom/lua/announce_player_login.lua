-----------------------------------
-- Announce when a player logs in
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('announce_player_login')
local UPDATE_NOTICE_LINE_1 = string.char(
    50,48,50,54,148,78,51,140,142,56,147,250,130,201,131,84,129,91,131,111,129,91,141,88,144,86,130,240,142,
    192,142,123,130,181,130,220,130,181,130,189,129,66,144,86,139,75,131,78,131,71,131,88,131,103,146,199,137,
    193,129,65,138,214,152,65,131,111,131,103,131,139,131,116,131,66,129,91,131,139,131,104,146,199,137,193,
    129,65,138,101,142,237,149,115,139,239,141,135,143,67,144,179,130,240,148,189,137,102,130,181,130,196,130,
    162,130,220,130,183,129,66
)
local UPDATE_NOTICE_LINE_2 = string.char(
    131,130,131,147,131,88,131,94,129,91,148,122,146,117,129,65,131,88,131,76,131,139,129,65,131,121,131,98,
    131,103,138,214,152,65,131,102,129,91,131,94,130,224,141,88,144,86,130,179,130,234,130,196,130,162,130,
    220,130,183,129,66,149,115,139,239,141,135,130,170,130,160,130,234,130,206,130,178,152,65,151,141,130,173,
    130,190,130,179,130,162,129,66
)

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
    super(player, firstLogin, zoning)

    if not zoning then
        -- ゾーン情報の初期化直後は表示順が不安定なため、少し待ってから既存のログイン通知を流す。
        player:timer(2500, function(playerArg)
            local decoratedMessage = string.format('Player %s has logged in.', playerArg:getName())
            -- 既存どおり、全ゾーンへログイン通知を配信する。
            playerArg:printToArea(decoratedMessage, xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM, '', true)
        end)

        -- Welcomeメッセージの後に見えるよう、更新告知はさらに遅らせて全体向けに2行で流す。
        player:timer(5000, function(playerArg)
            playerArg:printToPlayer(UPDATE_NOTICE_LINE_1, xi.msg.channel.SYSTEM_3, '')
        end)

        player:timer(6500, function(playerArg)
            playerArg:printToPlayer(UPDATE_NOTICE_LINE_2, xi.msg.channel.SYSTEM_3, '')
        end)
    end
end)

return m
