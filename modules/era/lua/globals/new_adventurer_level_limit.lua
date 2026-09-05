-----------------------------------
-- New Adventurer Level Up Module
-- New adventurer icon is no longer removed on level cap on retail. This restores removal once player reaches 6 or above.
-- Source: https://forum.square-enix.com/ffxi/threads/61014-August-9-2023-%28JST%29-Version-Update?p=656247&viewfull=1#post656247
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('new_adventurer_level_limit', xi.pre(xi.expansion.TVR))

local function checkNewPlayer(player)
    if not player:getNewPlayer() then
        return
    end

    if player:getJobLevel(player:getMainJob()) >= 6 then
        player:setNewPlayer(false)
    end
end

m:addOverride('xi.player.onPlayerLevelUp', function(player)
    super(player)

    checkNewPlayer(player)
end)
