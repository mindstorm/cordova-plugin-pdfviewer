# Cordova iOS PDF Viewer Plugin #


## 1. Function ##
View a local PDF file with the VFR Reader Core Library.
> based on https://github.com/vfr/Reader


## 2. Methods


### 2.1 showPDF


#### 2.1.1 Description
Shows the specified PDF with the VFR Reader.


#### 2.1.2 Options
<table>
	<tr>
		<th>Name</th>
		<th>Type</th>
		<th>Description</th>
		<th>Default</th>
	</tr>
	<tr>
		<td>url</td>
		<td>string</td>
		<td>url of the file</td>
		<td>(required)</td>
	</tr>
</table>


#### 2.1.3 Return Values


##### 2.1.3.1 Success
no return value.


##### 2.1.3.2 Error
<table>
	<tr>
		<th>Error Code</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>1</td>
		<td>no fileurl</td>
	</tr>
	<tr>
		<td>2</td>
		<td>file doesnt exists</td>
	</tr>
</table>


## 3. Requirements
- UIKit, Foundation, CoreGraphics, QuartzCore, ImageIO, MessageUI


## 4. Version History
<table>
	<tr>
		<th>Version</th>
		<th>Date</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>1.0.0</td>
		<td>2013-03-25</td>
		<td>initial version</td>
	</tr>
</table>
