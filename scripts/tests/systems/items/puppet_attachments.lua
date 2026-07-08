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
        player:setAttachment(xi.item.STROBE_ATTACHMENT, 5)
        player:spawnPet(xi.petId.AUTOMATON)

        local pet         = player:getPet()
        local attachments = nil
        local item        = nil
        if pet then
            attachments = pet:getAttachments()
        end

        assert(attachments)

        if attachments then
            item = attachments[5]
        end

        assert(item)
        assert(item == 'strobe',
            string.format('expected strobe, got %s', item))
    end)
end)
