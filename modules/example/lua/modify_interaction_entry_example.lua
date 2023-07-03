-----------------------------------
-- Modify interaction entry example
-----------------------------------
require('modules/module_utils')
require('scripts/globals/utils')
require('scripts/globals/interaction/interaction_global')
-----------------------------------
local m = Module:new('modify_interaction_entry_example')

-- When the server has started and everything is ready, apply interaction changes
m:addOverride('xi.server.onServerStart', function()
    -- Call super!
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/Rock_Bottom', function(quest)
        -- REMEMBER: Lua is 1-indexed!

        -- Disable the quest
        --
        -- This will cause the check in the first section to fail, and the quest will
        -- bottom out to the default action.
        -- Players who have flagged the other sections may still continue.
        -- NOTE: If you hot-reload the original quest file, it'll wipe out THIS
        --     : cache entry, undoing these changes.
        --     : YOU HAVE BEEN WARNED NOT TO HOT-RELOAD THINGS ON A LIVE SERVER!
        quest.sections[1].check = function(player, status, vars)
            return false
        end
    end)
end)

return m