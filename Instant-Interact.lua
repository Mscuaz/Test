for _, prompt in pairs(workspace:GetDescendants()) do
    if prompt:IsA("ProximityPrompt") then
        prompt.HoldDuration = 0 -- Removes hold requirement
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        descendant.HoldDuration = 0 -- Ensures new prompts are also instant
    end
end)
