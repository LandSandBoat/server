describe('Puppet attachments', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.PUP,
                level = 75,
                zone  = xi.zone.SOUTHERN_SAN_DORIA,
            })

        player:unlockAttachment(xi.item.HARLEQUIN_FRAME)
        player:unlockAttachment(xi.item.HARLEQUIN_HEAD)
        player:unlockAttachment(xi.item.STROBE_ATTACHMENT)
    end)

    it('equipped attachment is visible on the spawned automaton', function()
        player:setAttachment(xi.item.STROBE_ATTACHMENT, 0)
        player:spawnPet(xi.petId.AUTOMATON)

        local pet = player:getPet()
        assert(pet)

        local attachments = pet:getAttachments()
        assert(attachments)

        local item = attachments[0]
        assert(item)
        assert(item:getName() == 'strobe',
            string.format('expected strobe, got %s', item:getName()))
    end)
end)
