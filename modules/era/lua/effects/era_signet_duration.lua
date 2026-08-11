-----------------------------------
-- Era Signet Duration Module - Reduces duration of Signet effects by 3 hours.
-- Changed May 10th, 2011 : https://wiki.ffo.jp/html/564.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_signet_duration', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.conquest.bestowSignet', function(player, pNation, pRank, mOffset)
    super(player, pNation, pRank, mOffset)

    local signet = player:getStatusEffect(xi.effect.SIGNET)

    if signet then
        signet:setDuration(signet:getDuration() - 3 * 3600 * 1000)
    end
end)
