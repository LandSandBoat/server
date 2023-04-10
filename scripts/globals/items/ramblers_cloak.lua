-----------------------------------
-- ID: 11312
-- Equip: Ramblers Cloak
--  Latent effect: STR +5
-- Active when TP >= 100%, should not active during weapon skills
-- Note: Script is not working 100%, there is no check on equipment after it has been equipped or unequipped.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
end

return itemObject
