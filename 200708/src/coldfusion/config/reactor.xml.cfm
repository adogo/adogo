<reactor>
	
	<objects>
				
		<object name="books" alias="product">
			<hasOne name="author">
				<relate from="author_id" to="id" />
			</hasOne>
			<hasMany name="reviews">
				<relate from="id" to="book_id" />
			</hasMany>
		</object>
				
		<object name="authors" alias="author">
			<hasMany name="book">
				<relate from="id" to="author_id" />
			</hasMany>
		</object>
				
		<object name="reviews" alias="review">
			<hasOne name="book">
				<relate from="book_id" to="id" />
			</hasOne>
		</object>
		
	</objects>
		
</reactor>
