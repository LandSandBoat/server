-----------------------------------
-- Event Storage NPC Era Fee
-- Taking an item back costs 500 gil. The December 9, 2008 version update halved it to 250.
--
-- Source: http://www.playonline.com/pcd/update/ff11us/20051011YY3BV1/detail.html
-- Source: https://www.playonline.com/pcd/verup/ff11us/detail/3893/detail.html
-- Source: https://wiki.ffo.jp/html/6578.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_event_storage_fee', xi.pre(xi.expansion.WOTG))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.eventStorage.withdrawalFee = 500
end)

-- The modern client prints the 250 gil fee from its own string table and the server cannot change that text.
m:addOverride('xi.eventStorage.onTrigger', function(player, npc)
    super(player, npc)

    player:printToPlayer('Withdrawing an item costs 500 gil in this era.', xi.msg.channel.SYSTEM_3)
end)
