-----------------------------------
-- Remove the Imprimatur/Fame gating from the SOA main mission line
-----------------------------------
require("modules/module_utils")
require("scripts/missions/soa/helpers")
-----------------------------------
local m = Module:new("so_remove_imprimatur_gate")
m:setEnabled(false)

m:addOverride("xi.soa.helpers.imprimaturGate", function(player, gateAmount)
    -- Ignore the spending and fame requirements, just return true
    return true
end)

return m
