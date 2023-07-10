--------------------------------
-- Despawn non-persistent NMs --
--------------------------------

cmdprops =
{
    permission = 3,
    parameters = "s"
}

local nmTable = {
    17101201, -- Khimaira
    17027458, -- Cerberus
    16986355, -- Hydra
    17043875, -- Guluul Ja Ja
    17031592, -- Gurfurlur the Menacing
    16998862 -- Medusa
}

function onTrigger(player, target)
    for _, nm in ipairs( nmTable ) do
        DespawnMob(nm)
		-- print(string.format("%s", nm))
        -- player:PrintToPlayer(string.format("Despawned %s.", nm:getName()))
    end
end
