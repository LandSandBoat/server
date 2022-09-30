-----------------------------------
-- Holy Cow
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !gotoid 16801896
-----------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId = xi.battlefield.id.HOLY_COW,
    menuBit = 4,
    entryNpc = "Wind_Pillar_5",
    exitNpc = "Wind_Pillar_Exit",
    requiredKeyItems = { xi.ki.ZEPHYR_FAN },
    grantXP = 4000,
})

function content:onBattlefieldEnter(player, battlefield)
    if Battlefield.onBattlefieldEnter(player, battlefield) then
        player:messageSpecial(ID.text.ZEPHYR_RIPS, xi.ki.ZEPHYR_FAN)
    end
end

return content:register()
