const axios = require ('axios');
const cds = require('@sap/cds')

module.exports = cds.service.impl(async function(){
    const {ExternalApi} = this.entities;

    this.on('READ', ExternalApi, async(req)=>{

        try{
            const {data} = await axios.get('https://jsonplaceholder.typicode.com/posts');
            return data;
        }catch(err)
        {
           console.error('Failed to fetch posts:', err.message)
           req.error(500, 'Failed to fetch external data')
        }
    })
})