function [targetName, distance, transmitterPower] = read_xml(xmlFilePath)
    dom = xmlread(xmlFilePath);
    
    targetIdSections = dom.getElementsByTagName('Target_Identification');
    if targetIdSections.getLength() > 0
        targetIdNode = targetIdSections.item(0);
        nameNodes = targetIdNode.getElementsByTagName('name');
        if nameNodes.getLength() > 0
            targetName = strtrim(char(nameNodes.item(0).getTextContent()));
        else
            targetName = "Unknown";
        end
    else
        targetName = "Unknown";
    end
    
   powerNodes = dom.getElementsByTagName('radar:transmitter_power');
    if powerNodes.getLength() == 0
        powerNodes = dom.getElementsByTagName('transmitter_power');
    end
    
    if powerNodes.getLength() > 0
        transmitterPower = str2double(powerNodes.item(0).getTextContent());
    else
        transmitterPower = NaN;
    end
    
    lightTimeNodes = dom.getElementsByTagName('radar:transmitter_to_receiver_lighttime');
    if lightTimeNodes.getLength() == 0
        lightTimeNodes = dom.getElementsByTagName('transmitter_to_receiver_lighttime');
    end
    
    if lightTimeNodes.getLength() > 0
        dt = str2double(lightTimeNodes.item(0).getTextContent());
        
        c = 299792458; % speed of light in meters per second
        distance = (c * dt) / 2; % distance in meters
    else
        distance = NaN;
    end
end