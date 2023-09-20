package com.closet.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.UUID;

import javax.imageio.ImageIO;

import sun.misc.BASE64Decoder;

public class ScreenShotSave {
	
	public static String saveFile(String saveDir, String file) {
		 
		 String saveFileName = System.currentTimeMillis() + UUID.randomUUID().toString()+".png";
		 String filePath = saveDir + "/" + saveFileName;
		 
		 String[] strParts = file.split(",");
		 String rstStrImg = strParts[1];
		 
		 BufferedImage image = null;
		 byte[] byteImg;
		 
		 BASE64Decoder decoder = new BASE64Decoder();
		 try {
			 byteImg = decoder.decodeBuffer(rstStrImg);
		 	ByteArrayInputStream bis = new ByteArrayInputStream(byteImg);
		 	image = ImageIO.read(bis);
		 	ImageIO.write(image, "png", new File(filePath));
		 }catch(Exception e) {
			 System.out.print(e.toString());
		 }
		 
		 return saveFileName;
	}
}
