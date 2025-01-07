selectWindow("561_30%488_15%150nm200ms540mhz12bg4_200spf_lyza_1mpf_+sag10mxy01-1.tif");
run("Duplicate...", "title=duplicate.tif duplicate");
selectWindow("duplicate.tif");
run("Split Channels");
selectWindow("C1-duplicate.tif");
run("Subtract Background...", "rolling=20 stack");
run("ROI Manager...");
for (z=1;z<=256;z++) {
	open("location.csv");
	x=Table.get("x", z-1);
	y=Table.get("y", z-1);
	print(x);
	print(y);
    selectWindow("C1-duplicate.tif");
	setSlice(z);
	run("Select None");
    setAutoThreshold("Yen dark no-reset");
	run("Create Mask");
	selectWindow("mask");
	for (i = 0; i < 14; i++) {
		for (j = 0; j < 14; j++) {
			setPixel(x+i-6, y+j-6, 255);
	}
}
	setAutoThreshold("Yen dark no-reset");
	run("Create Selection");
	roiManager("Add");
	selectWindow("C2-duplicate.tif");
	setSlice(z);
	run("Select None");
	roiManager("Select", roiManager("size")-1);
	run("Measure");
	selectWindow("mask");
	close();

print(z);

}

