-----------------------------------
-- Testimony Single Use
-- Testimonies wear out after one battlefield entry instead of three
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('testimony_single_use', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('Battlefield.onBattlefieldEnter', function(self, player, battlefield)
    local itemId    = self.requiredItems[1]
    local totalUses = itemId and xi.battlefield.itemUses[itemId] or 1

    -- Testimony use messaging in battlefield.lua relies on the item potentially having more than 1 use
    -- For the message to display properly in game, fully increment wear upon entering the battlefield
    if
        totalUses > 1 and
        player:getID() == battlefield:getInitiator() and
        player:hasItem(itemId)
    then
        for _ = player:getWornUses(itemId) + 1, totalUses - 1 do
            player:incrementItemWear(itemId)
        end
    end

    super(self, player, battlefield)
end)
